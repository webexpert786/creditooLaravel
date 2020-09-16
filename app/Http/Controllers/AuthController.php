<?php
namespace App;
namespace App\Http\Controllers;
use App\User;
use App\Cms;
use App\CompanyDetails;
use App\ClaimAbout;
use App\Claims;
use App\CompanyClaims;
use App\CaseNotes;
use App\Invites;
use App\Projects;
use App\StaffCosts;
use App\EPWCosts;
use App\SubContractorsCosts;
use App\Costs;
use App\EmailTemplates;
use App\RolesPermission;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Mail;
use DateTime;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
class AuthController extends Controller
{
	
	
	
	/*
	* Register function
	*/
    public function register(Request $request){
		$requestData	=	$request->input();

		// check if phone is numeric or of 10 digits
		$phone	=	$this->checkPhone($requestData['phone']);	
		if(!empty($phone) && $phone['status'] == 1){
			$data['message'] 	=	$phone['msg'];
			$data['status']		=	false;
			return $data; die;
		}

		// check if email already exists
		$row	=	$this->checkEmailExist($requestData['email']);
		if(!empty($row)){
			$data['message'] 	=	'Email already exist!';
			$data['status']		=	false;
			return $data; die;
		}
		
		// Insert register columns to database
        $api_token 		= 	sha1(time());      
        $created_at 	= 	date('Y-m-d H:i:s');    
		$Userdata = array(
			'first_name' =>	$requestData['first_name'],
			'last_name'  =>	$requestData['last_name'],
			'email' 	 =>	$requestData['email'],
			'phone' 	 =>	$requestData['phone'],
			'password' 	 =>	$requestData['password'],
			'api_token'  =>	$api_token,
			'created_at' =>	$created_at,
		);
      	$UserCreate		= 	DB::table('users')->insertGetId($Userdata);

  		if(isset($requestData['role_id']))
      	{
      		// add user role
	      	$UserRole = array(
				'user_id' =>	$UserCreate,
				'role_id'  =>	$requestData['role_id'],
				'created_at' =>	$created_at,
			);
	      	$UserRoleCreate		= 	DB::table('user_roles')->insertGetId($UserRole);
      	}

      	// Send email
      	$to_email = $requestData['email'];

    	$getTemplate = EmailTemplates::where('email_id',2)->first(); // get template info

    	$fullName = ucfirst($requestData['first_name']).' '.ucfirst($requestData['last_name']);
    	$body = $getTemplate->body;
    	$subject = $getTemplate->subject;
    	$path = config('app.url');
    	
    	$finalBody =  str_replace(['#dearStr#','#btnLink#','#email#','#password#'], [$fullName,$path,$to_email,'Your choosen password'], $body);

		Mail::send([], [], function($message) use ($fullName, $to_email,$subject,$finalBody) {
            $message->from('info@creditool.co.uk','Creditool');
            $message->to($to_email);
            $message->subject($subject);
            $message->setBody($finalBody, 'text/html');
        });

		$GetData	= 	DB::table('users')->where(array('users.id'=>$UserCreate))
						->leftJoin('user_roles', 'users.id', '=', 'user_roles.user_id')
						->first();
      if($UserCreate ){
      	$data['message'] 	=	'User Created Successfully!';
      	$data['status']		=	true;
      	$data['data']		=	$GetData;
      	$data['role_id']	=	encrypt($GetData->role_id);
      }else {
      	$data['message'] 	=	'Something went wrong';
      	$data['status']		=	false;
      }
      return $data;
    }
	/*
	* Function to check Email Exists or not
	*/
	protected function checkEmailExist($email){
		return DB::table('users')->where(array('email'=>$email))->first();
	}	
	/*
	* Funtion to check phone number
	*/
	protected function checkPhone($phone){
		$data_p= array();
		if(!is_numeric($phone))
		{
			$data_p['msg'] = 'Phone number should be integer only';
			$data_p['status'] = 1;
		}
		if(is_numeric($phone))
		{
			if(strlen($phone)<10)
			{
				$data_p['msg'] = 'Phone number should be 10 digits';
				$data_p['status'] = 1;
			}
		}
		return $data_p;
	}

   public function guard()
    {
        return Auth::guard();
    }
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => auth()->refresh(),
            'token_type' => 'bearer',
            'expires_in' => $this->guard()->factory()->getTTL() * 60
        ]);
    }
	
	    /**
     * Get the authenticated User
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json($this->guard()->user());
    }


    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken($this->guard()->refresh());
    }



	/*
	* Function for login user
	*/
    public function login(Request $request)
    {
		
		$credentials = $request->only('email', 'password');

        if ($token = $this->guard()->attempt($credentials)) {
			
			$email 		= $request->input('email');
			$UserGet	= DB::table('users')->select(DB::raw('users.*,users.id as user_id,user_roles.role_id'))->where(array('email'=>$email))
							->leftJoin('user_roles', 'users.id', '=', 'user_roles.user_id')
							->first();
						
			  if(!empty($UserGet)){		
				if($UserGet->status ==0){
					$data['message'] 	=	'Your account is inactive, kindly contact admin';
					$data['status']		=	false;
					$data['data']		=	'';
				}else{			  
					$UserGet->api_token	=	$token;	
					$data['message'] 	=	'User Logged in Successfully!';
					$data['status']		=	true;
					$data['data']		=	$UserGet;
					$data['role_id']	= 	encrypt($UserGet->role_id);  
				}
			  }else {
				$data['message'] 	=	'Invalid login details! Please try again.';
				$data['status']		=	false;
				$data['data']		=	'';
			  }
        }else {
				$data['message'] 	=	'Invalid login details! Please try again.';
				$data['status']		=	false;
				$data['data']		=	'';
		}

         return $data;
    }

    /*
    * Forget Password function
    */
    public function forgetPassword(Request $request)
    {
    	$email = $request->input('email');

    	if(empty($email))
    	{
    		$data['message'] = 'Email can not be empty';
    		$data['status'] =false;

    		return $data; die;
    	}

    	$emailCheck = $this->checkEmailExist($email);

    	if(empty($emailCheck))
    	{
    		$data['message'] = 'Email is not found on our record!';
    		$data['status'] = false;

    		return $data; die;
    	}

	    $passwordReset =	DB::table('password_resets')->insert([
		        'email' => $request->email,
		        'token' => Str::random(60), 
		        'created_at' => date('Y-m-d H:i:s')
		    ]);

	    $tokenData = DB::table('password_resets')
		    		->where('email', $request->email)->orderby('created_at','desc')->first();

	   $token = $tokenData->token;
	   $email = $request->email;

	   $resetPath = ('reset-password/'.$token);

	  // return $resetPath;
	   	// Send email code
    	
		$to_email = $email;

    	$getTemplate = EmailTemplates::where('email_id',3)->first(); // get template info
    	$GetData	= 	DB::table('users')->where(array('email'=>$email))->first(); // Get user  

    	$fullName = ucfirst($GetData->first_name).' '.ucfirst($GetData->last_name);
    	$body = $getTemplate->body;
    	$subject = $getTemplate->subject;
    	$path = config('app.url').$resetPath;
    	
    	$settings 	= 	DB::table('settings')->first();
        $logo = URL::to('/images/'.$settings->logo);
    	
    	$finalBody =  str_replace(['#dearStr#','#btnLink#','#logo#','#baseUrl#'], [$fullName,$path,$logo,config('app.url')], $body);
	
		/*$mail = Mail::raw($finalBody, function($message) use ($fullName, $to_email,$subject) {
			$message->to($to_email, $fullName);
			$message->subject($subject);
			$message->from('info@creditool.co.uk','Creditoo');
		});
*/
		 Mail::send([], [], function($message) use ($fullName, $to_email,$subject,$finalBody) {
            $message->from('info@creditool.co.uk','Creditool');
            $message->to($to_email);
            $message->subject($subject);
            $message->setBody($finalBody, 'text/html');
        });

		if(empty(Mail::failures())){
			$data['message'] 	= 'Please check your mailbox .';
    		$data['status'] 	= true;
		}else{
			$data['message'] 	= 'Something went wrong!';
    		$data['status'] 	= false;
		}
    		return $data; die;
    }

    /*
    * Function to reset password
    */
    public function resetPassword(Request $request,$token)
    {
    	$tokenCheck = $this->checkToken($token);
    	if(empty($tokenCheck))
    	{
    		$data['message'] = 'Wrong token!';
    		$data['status'] = false;

    		return $data; die;
    	}
    	
    	$newPassword = $request->input('password');
    	$confirmNewPassword = $request->input('confirm_password');

    	if($newPassword != $confirmNewPassword)
    	{
    		$data['message']='Passwords not matched!';
    		$data['status'] =false;

    		return $data;die;
    	}

    	// get user data by the token
    	$tokenData = DB::table('password_resets')->where('token', $token)->first();
    	// check if token is expired or not

    	$tokenDate = $tokenData->created_at;
    	$currentDate = now();

    	$datetime1 = new DateTime($tokenDate);
		$datetime2 = new DateTime($currentDate);
		$interval = $datetime1->diff($datetime2);
		$days = $interval->format('%a');//now do whatever you like with $days

		$userArray = array(
			'password' => Hash::make($newPassword),
		);

		if($days < 1)
		{
			$passUpdate = User::where('email',$tokenData->email)->update($userArray);

			if($passUpdate)
			{
				$data['message'] = 'Password Updated successfully!';
				$data['status'] = true;
			}
			else{
				$data['message'] = 'Something went wrong!';
				$data['status']= false;
			}

			return $data;
		}
		else{
			$data['message'] = 'Token expired,try again';
			$data['status'] = false;

			return $data; die;
		}
		
		

		
    }

    /*
    * Check if token exists or not
    */
    protected function checkToken($token)
    {
    	return DB::table('password_resets')->where(array('token'=>$token))->first();
    }

    /*
	* Function to get list of users
	*/
    public function getUsers(Request $request)
    {
		
		$currentUser = Auth::user();

        $page 		= $request->input('page') ;
        $limit 		= $request->input('limit');
        $filter		= $request->input('filter');
        $sortField 	= $request->input('sortField')??'id';
        $sortOrder 	= $request->input('sortOrder')??'desc';
		$totalUsers	= 0;
		$new		= DB::query()->fromSub(function ($query) use($filter,$limit,$page,$totalUsers) {
			$UserGet		= $query
							->Select('users.*','users.id as user_id ','user_roles.role_id','roles.role_name',DB::Raw("IFNULL( roles.editable , 0 ) as editable"))->from('users');
							
			if(!empty($filter) ){				
				$UserGet		= $UserGet
									->Where(function ($query) use ($filter) {
										$query->orWhere('first_name','LIKE', "%$filter%")
											->orWhere('last_name','LIKE', "%$filter%")
											->orWhere('email','LIKE', "%$filter%");
									});
			}					
							
			$UserGet		= $UserGet->leftJoin('user_roles', 'users.id', '=', 'user_roles.user_id')
								->leftJoin('roles', function($advancedLeftJoin){
									$advancedLeftJoin->on('roles.id', '=', 'user_roles.role_id'); 
								});
			
			

			
		}, 'a');
		$new	=	$new->where('a.editable','<>',1)->where('a.id','<>',$currentUser->id);

			$totalUsers		= count($new->get());
			

			if(!empty($limit)){
				$UserGet		= $new->limit($limit)->offset(($page) * $limit)->get();
			}
			else{
				$UserGet		= $new->get();
			}
			
			


					
	      if(count($UserGet) > 0)
	      {
	      	$data['message'] 	= 'Get users list';
	      	$data['status']		= true;
	      	$data['data']		= $UserGet;
	      	$data['count']		= $totalUsers;
	      	//$data['user_role']		= $UserRole->role_name;
	      }else {
	      	$data['message'] 	= 'Users list not found';
	      	$data['status']		=  false;
	      	$data['data']		=  'No user found!';
	      	$data['count']		=  0;
	      }
	      return $data;
    }

    /*
	* Function to add user
	*/
    public function addUser(Request $request)
    {
       	$requestData	=	$request->input();

		// check if phone is numeric or of 10 digits
		// $phone	=	$this->checkPhone($requestData['phone']);	
		// if(!empty($phone) && $phone['status'] == 1){
			// $data['message'] 	=	$phone['msg'];
			// $data['status']		=	false;
			// return $data; die;
		// }

		// check if email already exists
		$row	=	$this->checkEmailExist($requestData['email']);
		if(!empty($row)){
			$data['message'] 	=	'Email already exist!';
			$data['status']		=	false;
			return $data; die;
		}
		
		// Insert register columns to database
        $api_token 		= 	sha1(time());      
        $created_at 	= 	date('Y-m-d H:i:s');    
		$Userdata = array(
			'first_name' =>	$requestData['first_name'],
			'last_name'  =>	$requestData['last_name'],
			'email' 	 =>	$requestData['email'],
			// 'phone' 	 =>	$requestData['phone'],
			'password' 	 =>	hash::make($requestData['password']),
			'api_token'  =>	$api_token,
			'created_at' =>	$created_at,
		);
      	$UserCreate		= 	DB::table('users')->insertGetId($Userdata); // add user

      	if(isset($requestData['role_id']))
      	{
      		// add user role
	      	$UserRole = array(
				'user_id' =>	$UserCreate,
				'role_id'  =>	$requestData['role_id'],
				'created_at' =>	$created_at,
			);
	      	$UserCreate		= 	DB::table('user_roles')->insertGetId($UserRole);
      	}
		$GetData	= 	DB::table('users')->where(array('id'=>$UserCreate))->first(); // Get user 
      if($UserCreate){
      	$data['message'] 	=	'User added Successfully!';
      	$data['status']		=	true;
      	$data['data']		=	$GetData;
      }else {
      	$data['message'] 	=	'Something went wrong';
      	$data['status']		=	false;
      }
      return $data;
    }

    /*
	* Function to view user
	*/
    public function viewUser(Request $request)
    {
    	$userID = request()->segment(count(request()->segments()));
    	$GetData	= 	DB::table('users')->where(array('id'=>$userID))->first(); // Get user 
    	//print_r($GetData);die;
    	if(!empty($GetData))
    	{
    		$GetUserRole	= 	DB::table('user_roles')->where(array('user_id'=>$userID))->first(); // Get user Role
      		$UserRole	= 	DB::table('roles')->where(array('id'=>$GetUserRole->role_id))->first(); // Get user Role name      		
    		$getRolePerm = RolesPermission::where('role_id',$GetUserRole->role_id)->get(); // Get role permissionz

    	}
    	
      if(!empty($GetData) && !empty($GetUserRole)){

		$GetData->role_id	=	$GetUserRole->role_id;
      	$data['message'] 	=	'User information retrived Successfully!';
      	$data['status']		=	true;
      	$data['data']		=	$GetData;
      	$data['role_id']	=	$GetUserRole->role_id;
      	$data['user_role']	=	$UserRole->role_name??null;
      	$data['role_permission']	=	$getRolePerm;
      }else {
      	$data['message'] 	=	'Something went wrong';
      	$data['status']		=	false;
      }
      return $data;
    }

    /*
	* Function to edit user
	*/
    public function editUser(Request $request)
    {
    	$userID = request()->segment(count(request()->segments()));
    	$requestData	=	$request->input();
    	// check if phone is numeric or of 10 digits
    	if(isset($requestData['phone']))
    	{
    		$phone	=	$this->checkPhone($requestData['phone']);	
			if(!empty($phone) && $phone['status'] == 1){
				$data['message'] 	=	$phone['msg'];
				$data['status']		=	false;
				return $data; die;
			}
    	}
		
		if(isset($requestData['email']))
		{
			$data['message'] 	=	'Email can not be changed!';
			$data['status']		=	false;
			return $data; die;
		}
		
		// Insert register columns to database
        $updated_at 	= 	date('Y-m-d H:i:s');    
		$Userdata = array(
			'first_name' =>	$requestData['first_name'],
			'last_name'  =>	$requestData['last_name'],
			'phone' 	 =>	$requestData['phone'],
			'updated_at' =>	$updated_at,
		);
		
		if(isset($requestData['password']))
		{
			$Userdata['password']	=	$requestData['password'];
		}
		
      	$UserUpdate		= 	DB::table('users')->where('id',$userID)->update($Userdata); // update user
      	$GetUser		= 	DB::table('users')->where(array('id'=>$userID))->first(); // Get user Role
      	if(isset($requestData['role_id']))
      	{
      		// add user role
	      	$UserRole = array(
				'role_id'  =>	$requestData['role_id'],
				'updated_at' =>	$updated_at,
			);
	      	$UserUpdateData		= 	DB::table('user_roles')->where('user_id',$userID)->update($UserRole);
	      	$GetUserRole	= 	DB::table('user_roles')->where(array('user_id'=>$userID))->first(); // Get user Role
    		$UpdateUserRole	= 	DB::table('roles')->where(array('id'=>$GetUserRole->role_id))->first(); // Get user Role name
      	}      

      if($GetUser && $UpdateUserRole){
		  
		  DB::table("users")->where('id',$userID)->update(['status'=>1]);
		  
      	$data['message'] 	=	'User information updated Successfully!';
      	$data['status']		=	true;
      	$data['data']		=	$GetUser;
      	$data['user_role']	=	$UpdateUserRole->role_name;
      }else {
      	$data['message'] 	=	'Something went wrong';
      	$data['status']		=	false;
      }
      return $data;
    }

    /*
    * Function to delete user
    */

    public function deleteUser(Request $request)
    {
    	$userID = request()->segment(count(request()->segments()));
    	
    	$delUser = DB::table('users')->where('id', '=', $userID)->delete();

    	$delUserRole = DB::table('user_roles')->where('user_id', '=', $userID)->delete();

    	if($delUser){
      	$data['message'] 	=	'User information deleted Successfully!';
      	$data['status']		=	true;
      }else {
      	$data['message'] 	=	'Something went wrong';
      	$data['status']		=	false;
      }
      return $data;
    }

    /*
	* Function to get list of client_company
	*/
    public function getclients(Request $request)
    {
        $page = $request->input('page') ;
        $limit = $request->input('limit');
        $filter = $request->input('filter');
        $sortField = $request->input('sortField')??'company_id';
        $sortOrder = $request->input('sortOrder')??'desc';

        if(!empty($limit)  || !empty($filter)  )
        {	
        	if((!empty($filter) || !empty($sortField) && !empty($sortOrder) ))
        	{

        		$UserGet		= DB::table('client_company')
        						->where('company_name','LIKE', "%$filter%")
        						->orWhere('email','LIKE', "%$filter%")
        						->limit($limit)->offset(($page) * $limit)->orderBy($sortField, $sortOrder)->get();
								
				$totalUsers		= count(DB::table('client_company')
        						->where('company_name','LIKE', "%$filter%")
        						->orWhere('email','LIKE', "%$filter%")->get());
        	}
        	else{
        		$UserGet		= DB::table('client_company') 
        						->limit($limit)->offset(($page) * $limit)->orderBy('company_id', 'desc')->get();
				$totalUsers		= count(DB::table('client_company')->get());
        	}
			
			//$UserRole	= 	DB::table('roles')->where(array('id'=>$UserGet->role_id))->first(); // Get user Ro
        }
		else{
			
			$UserGet		= DB::table('client_company')->orderBy('company_id', 'desc')->get(); 
			$totalUsers		= count($UserGet);
		}
		
		foreach($UserGet as $client){
			$inprogress 				= DB::table('claims')->where('company_id',$client->company_id)->where('status','in-progress')->get();
			$completed 					= DB::table('claims')->where('company_id',$client->company_id)->where('status','completed')->get();
			$ineligible 				= DB::table('claims')->where('company_id',$client->company_id)->where('status','in-eligible')->get();
			$client->claims_inprogress 	= $inprogress->count();
			$client->claims_completed 	= $completed->count();
			$client->claims_ineligible 	= $ineligible->count();
			$newArray[]					=	$client;
		}
		
					
	      if(count($UserGet) > 0)
	      {
	      	$data['message'] 						= 'Get clients list';
	      	$data['status']							= true;
	      	$data['data']							= $newArray;
	      	$data['count']							= $totalUsers;
	      }else {
	      	$data['message'] 	= 'clients list not found';
	      	$data['status']		=  false;
	      	$data['data']		=  'No user found!';
	      	$data['count']		=  0;
	      }
	      return $data;
    }

    /*
    * Function to add client
    */

    public function addClient(Request $request)
    {	
    	$requestData	=	$request->input();

    	// check if added_by is register user or not

    	$user = $this->checkUser($requestData['added_by']);
    	if(empty($user))
    	{
    		$data['message'] 	=	'User not found with added by ID!';
			$data['status']		=	false;
			return $data; die;
    	}
    	// check if phone is numeric or of 10 digits
		// $phone	=	$this->checkPhone($requestData['phone']);	
		// if(!empty($phone) && $phone['status'] == 1){
			// $data['message'] 	=	$phone['msg'];
			// $data['status']		=	false;
			// return $data; die;
		// }

		// check if email already exists
		$row	=	$this->checkClientEmailExist($requestData['email']);
		if(!empty($row)){
			$data['message'] 	=	'Email already exist!';
			$data['status']		=	false;
			return $data; die;
		}
		
		// check if date is validated or not 
		$date = date("Y-m-d", strtotime($requestData['incorporated_date']));

		// Insert into database
    	$added_by = $requestData['added_by'];
    	$company_name = $requestData['company_name'];
    	$email = $requestData['email'];
    	$phone = $requestData['phone'];
    	$company_reg = $requestData['company_reg'];
    	$directory_name = $requestData['directory_name'];
    	$incorporated_date = $date;
    	$created_at = date('Y-m-d h:i:s');      
		$Clientdata = array(
			'added_by' 			=>	$added_by,	
			'company_name' 		=>	$company_name,			
			'email' 	 		=>	$email,
			'phone' 	 		=>	$phone,
			'company_reg' 		=>	$company_reg,
			'directory_name'  	=>	$directory_name,
			'incorporated_date' =>	$incorporated_date,
			'created_at' 		=>	$created_at,
		);
      	$ClientCreate		= 	DB::table('client_company')->insertGetId($Clientdata); // add user
      	      	
		$GetData	= 	DB::table('client_company')->where(array('company_id'=>$ClientCreate))->first(); // Get user 
      if($ClientCreate){
      	$data['message'] 	=	'Client added Successfully!';
      	$data['status']		=	true;
      	$data['data']		=	$GetData;
      }else {
      	$data['message'] 	=	'Something went wrong';
      	$data['status']		=	false;
      }
      return $data;

    }

    /*
    * Function to edit client
    */

    public function getCompany(Request $request,$company_id)
    {
		// $company_id	=	$request->input('company_id');   	
		$GetData	= 	DB::table('client_company')->where(array('company_id'=>$company_id))->first(); 
		if($GetData){
			$data['message'] 	=	'Client retrieved Successfully!';
			$data['status']		=	true;
			$data['data']		=	$GetData;
		}else {
			$data['message'] 	=	'Something went wrong';
			$data['status']		=	false;
		}
		return $data;
	}

	/*
    * Function to edit client
    */

    public function editClient(Request $request,$client_id)
    {	
    	$requestData	=	$request->input();

    	// check if client exists
    	$client_id = $this->checkClientExist($client_id);

    	if(empty($client_id))
    	{
    		$data['message'] 	=	'Client not found with defined ID!';
			$data['status']		=	false;
			return $data; die;
    	}

    	// check if added_by is register user or not

    	$user = $this->checkUser($requestData['added_by']);
    	if(empty($user))
    	{
    		$data['message'] 	=	'User not found with added by ID!';
			$data['status']		=	false;
			return $data; die;
    	}
    	// check if phone is numeric or of 10 digits
		$phone	=	$this->checkPhone($requestData['phone']);	
		if(!empty($phone) && $phone['status'] == 1){
			$data['message'] 	=	$phone['msg'];
			$data['status']		=	false;
			return $data; die;
		}

		// check if email already exists
		$row	=	$this->checkClientEmailExist($requestData['email'],$client_id);
		if(!empty($row)){
			$data['message'] 	=	'Email already exist!';
			$data['status']		=	false;
			return $data; die;
		}
		
		// check if date is validated or not 
		$date = date("Y-m-d", strtotime($requestData['incorporated_date']));

		// Insert into database
    	$added_by = $requestData['added_by'];
    	$company_name = $requestData['company_name'];
    	$email = $requestData['email'];
    	$phone = $requestData['phone'];
    	$company_reg = $requestData['company_reg'];
    	$directory_name = $requestData['directory_name'];
    	$incorporated_date = $date;
    	$created_at = date('Y-m-d h:i:s');      
		$Clientdata = array(
			'added_by' 			=>	$added_by,	
			'company_name' 		=>	$company_name,			
			'email' 	 		=>	$email,
			'phone' 	 		=>	$phone,
			'company_reg' 		=>	$company_reg,
			'directory_name'  	=>	$directory_name,
			'incorporated_date' =>	$incorporated_date,
			'created_at' 		=>	$created_at,
		);
      	$ClientCreate		= 	DB::table('client_company')->where('company_id',$client_id)->update($Clientdata); // add user
      	      	
		$GetData	= 	DB::table('client_company')->where(array('company_id'=>$client_id))->first(); // Get user 
      if($ClientCreate){
      	$data['message'] 	=	'Client added Successfully!';
      	$data['status']		=	true;
      	$data['data']		=	$GetData;
      }else {
      	$data['message'] 	=	'Something went wrong';
      	$data['status']		=	false;
      }
      return $data;

    }
    /*
    * Check if client email already exists
    */
	protected function checkClientEmailExist($email,$client_id=null){
		// return DB::table('client_company')->where(array('email'=>$email))->where('company_id','!=',$client_id)->first();
		return DB::table('client_company')->where(array('email'=>$email))->first();
	}	

	/*
    * Check if client email already exists
    */
	protected function checkClientExist($client_id){
		return DB::table('client_company')->where(array('company_id'=>$client_id))->first();
	}	
    /*
    * Check if user exists
    */
    protected function checkUser($added_by){
		return DB::table('users')->where(array('id'=>$added_by))->first();
	}	

	/*
	* View Page function
	*/

	public function viewPage($id)
	{	
		$page = $this->checkPage($id);

		if(empty($page))
		{
			$data['message'] = 'Page not found!';
			$data['status'] = false;

			return $data; die;
		}

		$GetData	= 	DB::table('cms')->where(array('id'=>$id))->first(); 
    	
      if(!empty($GetData)){
      	$data['message'] 	=	'CMS information retrived Successfully!';
      	$data['status']		=	true;
      	$data['data']		=	$GetData;
      }else {
      	$data['message'] 	=	'Something went wrong';
      	$data['status']		=	false;
      }
      return $data;
	}	
	
	/*
	* Get Page By Slug function
	*/

	public function getPageBySlug($slug)
	{	
		// $page = $this->checkPage($id);

		// if(empty($page))
		// {
			// $data['message'] = 'Page not found!';
			// $data['status'] = false;

			// return $data; die;
		// }

		$GetData	= 	DB::table('cms')->where(array('cms_slug'=>$slug,'cms_status'=>1))->first(); 
    	
      if(!empty($GetData)){
      	$data['message'] 	=	'CMS information retrived Successfully!';
      	$data['status']		=	true;
      	$data['data']		=	$GetData;
      }else {
      	$data['message'] 	=	'Something went wrong';
      	$data['status']		=	false;
      }
      return $data;
	}

	/*
	* Add page function
	*/

	public function addPage(Request $request)
	{
		$requestData	=	$request->input();

		$page_title = $requestData['title'];
		$page_slug = $requestData['slug'];
		$meta_title = $requestData['meta_title'];
		$meta_keyword = $requestData['meta_keyword'];
		$meta_description = $requestData['meta_description'];
		$page_detail = $requestData['detail'];
		$page_status = $requestData['status']??0;
		$created_at = date('Y-m-d H:i:s');

		$user = $this->checkUser($requestData['added_by']);
		if(empty($user))
    	{
    		$data['message'] 	=	'User not found with added by ID!';
			$data['status']		=	false;
			return $data; die;
    	}
		$slugCheck = $this->checkSlug($page_slug);
		if($slugCheck)
		{
			$data['message'] ='Slug alread exists, try other slug';
			$data['status'] = false;

			return $data; die;
		}

		// if(!is_numeric($page_status) || !in_array($page_status,array(0,1)))
		// {
			// $data['message'] = 'Status can either be 0 or 1';
			// $data['status'] = false;

			// return $data; die;
		// }

		$pagearray = array(
			'cms_title' => $page_title,
			'cms_slug'  => $page_slug,
			'cms_meta_title' => $meta_title,
			'cms_meta_keyword' => $meta_keyword,
			'cms_meta_description' => $meta_description,
			'cms_detail' => $page_detail,
			'cms_status' => $page_status,
			'created_at' => $created_at
		);

		$addPage = CMS::insertGetId($pagearray);
		$getPage = CMS::where('id',$addPage)->first();
		if(isset($addPage))
		{
			$data['message'] = 'Page added Successfully!';
			$data['status'] = true;
			$data['page_data'] = $getPage; 
		}
		else{
			$data['message'] = 'Page addition Failed!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
    * Check if slug exists
    */
    protected function checkSlug($slug){
		return DB::table('cms')->where(array('cms_slug'=>$slug))->first();
	}	

	/*
	* Function to edit page 
	*/
	public function editPage(Request $request,$page_id)
	{
		$requestData	=	$request->input();

		$added_by = $requestData['added_by'];
		$page_title = $requestData['title'];
		$page_slug = $requestData['slug'];
		$meta_title = $requestData['meta_title'];
		$meta_keyword = $requestData['meta_keyword'];
		$meta_description = $requestData['meta_description'];
		$page_detail = $requestData['detail'];
		$page_status = $requestData['status'];
		$updated_at = date('Y-m-d H:i:s');

		$user = $this->checkUser($requestData['added_by']);
		if(empty($user))
    	{
    		$data['message'] 	=	'User not found with added by ID!';
			$data['status']		=	false;
			return $data; die;
    	}

		$page = $this->checkPage($page_id);

		if(empty($page))
		{
			$data['message'] = 'Page not found!';
			$data['status'] = false;

			return $data; die;
		}

		$slugCheck = $this->checkSlug($page_slug);
		if($slugCheck && $slugCheck->id != $page_id)
		{
			$data['message'] ='Slug alread exists, try other slug';
			$data['status'] = false;

			return $data; die;
		}

		// if(!is_numeric($page_status) || $page_status !=0 || $page_status !=1)
		// {
		// 	$data['message'] = 'Status can either be 0 or 1';
		// 	$data['status'] = false;

		// 	return $data; die;
		// }
		$pageArray = array(
			'cms_title' => $page_title,
			'cms_slug'  => $page_slug,
			'cms_meta_title' => $meta_title,
			'cms_meta_keyword' => $meta_keyword,
			'cms_meta_description' => $meta_description,
			'cms_detail' => $page_detail,
			'cms_status' => $page_status,
			'updated_at' => $updated_at
		);

		$updatePage = CMS::where('id',$page_id)->update($pageArray);
		$getPage = CMS::where('id',$page_id)->first();
		if(isset($updatePage))
		{
			$data['message'] = 'Page updated Successfully!';
			$data['status'] = true;
			$data['page_data'] = $getPage; 
		}
		else{
			$data['message'] = 'Page updation Failed!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to delete page
	*/

	public function deletePage($page_id)
	{
		$page = $this->checkPage($page_id);

		if(empty($page))
		{
			$data['message'] = 'Page not found!';
			$data['status'] = false;

			return $data; die;
		}

		$delPage= CMS::where('id',$page_id)->delete();
		if($delPage)
		{
			$data['message']  = 'Page is deleted successfully!';
			$data['status'] = true;
		}
		else{
			$data['message'] = 'Deletion failed!';
			$data['status'] =false;
		}

		return $data;
	}

	/*
    * Check if page exists
    */
    protected function checkPage($page){
		return DB::table('cms')->where(array('id'=>$page))->first();
	}

	/*
	* List pages function
	*/

	public function allPages(Request $request)
	{
		$data 	= $request->all() ;
		$page = $request->input('page')??0 ;
        $limit = $request->input('limit')??5;
        $filter = $request->input('filter');
        $sortField = !empty($request->input('sortField'))? $request->input('sortField') == 'first_name'?'cms_title':$request->input('sortField'):'cms_title';
        $sortOrder = $request->input('sortOrder')??'asc';


        $RolesGet		= DB::table('cms');
		if(!empty($data['filter'])){
			$RolesGet	=	$RolesGet->where('cms_title','Like',$data['filter'])->orWhere('cms_slug','LIKE',$data['filter']);
		}

		$totalPages			= count($RolesGet->get());
        if(!empty($limit)){
        	$RolesGet		= $RolesGet->limit($limit)->offset(($page) * $limit)->get();
        }
		else{
			$RolesGet		= $RolesGet->get();
		}


					
	      if(count($RolesGet) > 0)
	      {
	      	$data['message'] 	= 'Get pages list';
	      	$data['status']		= true;
	      	$data['data']		= $RolesGet;
	      	$data['count']		= $totalPages;
	      	//$data['user_role']		= $UserRole->role_name;
	      }else {
	      	$data['message'] 	= 'Pages list not found';
	      	$data['status']		=  false;
	      	$data['data']		=  'No page found!';
	      	$data['count']		=  0;
	      }
	      return $data;
	}
	/*
	* Check if company exists or not
	*/

	protected function companyCheck($company_id)
	{
		return CompanyDetails::where('company_id',$company_id)->first();
	}

	/*
	* Function to add Claim to database
	*/

	public function addClaim(Request $request)
	{	
		$company_id = $request->input('company_id');

		// $company_id = $requestData['company_id'];
		
		$companyCheck = $this->companyCheck($company_id);
		if(empty($companyCheck))
		{
			$data['message'] = 'Company Not Found!';
			$data['status'] = false;

			return $data; die;
		}
		$created_at = date('Y-m-d h:i:s');      
		$addClaim =  DB::table('claims')->insertGetId(array('company_id'=>$company_id,'endDate'=>'2020-06-04',"status"=>'in-progress',"created_at"=>$created_at));

		if($addClaim)
		{
			
			$claimsData				=	DB::table('claims')->where(array('id'=>$addClaim))->first(); 
			$companyData			=	DB::table('client_company')->where(array('company_id'=>$company_id))->first(); 
			$data['message'] 		= 	'Claim added successfully!';
			$data['status'] 		= 	true;
			$data['claim_id']	 	= 	$addClaim;
			$data['companyData'] 	= 	$companyData;
			$data['claimsData'] 	= 	$claimsData;
		}
		else{
			$data['message'] = 'Something went wrong';
			$data['status'] = false;
		}

		return $data;
	}
	/*
	* Function to update Claim
	*/
	public function updateClaim(Request $request,$company_id){
		$request['updated_at'] 	= 	date('Y-m-d H:i:s');  
		$data					=	$request->all();	
      	$UserUpdate				= 	DB::table('claims')->where('id',$company_id)->update($data); // update user
		
		if(!empty($UserUpdate))
		{
			$result['message'] 	= 'Claim updated successfully !';
			$result['status'] 	= true;

		}
		else{
			$result['message'] = 'Something went wrong!';
			$result['status'] = false;
		}
		return $result;
	}
	
	/*
	* Function to update  Claim progress
	*/
	public function updateClaimProgress(Request $request,$id,$module){	
		$data[$module]	=	"true";
		if(!empty($data)){
			$res	=	Claims::where('id',$id)->update($data);
			if(!empty($res)){
				$result['message'] 	= 'Progress updated';
				$result['status']	=  true;
			}else{
				$result['message'] 	= 'Something went wrong';
				$result['status']	=  false;
			}
		}else{
			$result['message'] 	= 'Empty data';
			$result['status']	=  false;
		}
		return $result;
	}	
	function updateClaimProgressPrivate($data,$id){
		if(!empty($data)){
			$res	=	Claims::where('id',$id)->update($data);
			if(!empty($res)){
				// $result['message'] 	= 'Progress updated';
				$result['status']	=  true;
			}else{
				// $result['message'] 	= 'Something went wrong';
				$result['status']	=  false;
			}
		}else{
			// $result['message'] 	= 'Empty data';
			$result['status']	=  false;
		}
		return $result;
	}
	
	/*
	* Function to get list of all Claims
	*/
	public function getAllClaims(Request $request,$company_id){
		$page 		= 	$request->input('page')??0 ;
        $limit 		= 	$request->input('limit')??1;
        $filter 	= 	$request->input('filter');
        $sortField 	= 	$request->input('sortField')??'id';
        $sortOrder 	= 	$request->input('sortOrder')??'desc';
		
		$ClaimsGet	= 	Claims::where('company_id',$company_id)
								->leftJoin('company_claims','claims.id','=','company_claims.claim_id')
								->limit($limit)
								->offset(($page) * $limit)
								->orderBy('claims.id', 'desc')
								->get();
								
		$totalPages	= 	Claims::where('company_id',$company_id)->get();	
		
		$settings 	= 	DB::table('settings')->first();
								
		foreach($ClaimsGet as $claim){
			$claim_id				=	$claim->id;
			$projectGet 			=	DB::table('company_projects')->where('claim_id',$claim_id)
										->where('company_projects.project_status','Like','approved')
										->get();
										
			// check if Technical section is completed
			$commercial_goals		= 	DB::table('commercial_goals')->where('claim_id',$claim_id)->get();
			$aims 			  		= 	DB::table('aims')->where('claim_id',$claim_id)->get();
			$difficulties 			= 	DB::table('difficulties')->where('claim_id',$claim_id)->get();
			$technical_challenge 	= 	DB::table('technical_challenge')->where('claim_id',$claim_id)->get();
			$non_tech_area	 		= 	DB::table('non_tech_area')->where('claim_id',$claim_id)->get();

			$staffCost 				= 	StaffCosts::where('claim_id',$claim_id)->get();
			$EPWCost				= 	EPWCosts::where('claim_id',$claim_id)->get();
			$SubContractorsCosts 	= 	SubContractorsCosts::where('claim_id',$claim_id)->get();
			$costs 					= 	Costs::where('claim_id',$claim_id)->get();
			
			$declaration 			= 	DB::table('declaration')->where('claim_id',$claim_id)->get();
			$reportData				= 	DB::table('reports')->where('claim_id',$claim_id)->first();
			if(!empty($reportData)){
				$claim->report_date		= 	$reportData->created_at;
			}else{
				$claim->report_date		= 	'-';
			}
			
			if($claim->year_end_date!=null){
				$claim->claim_period = date('d/m/Y', strtotime($claim->year_end_date.' -1 year')).' - '.date('d/m/Y', strtotime($claim->year_end_date));
			}else{
				$claim->claim_period = date('d/m/Y', strtotime($claim->endDate.' -1 year')).' - '.date('d/m/Y', strtotime($claim->endDate));
			}
			
			
			if(count($commercial_goals)!=0 && count($aims)!=0 && count($difficulties)!=0 && count($technical_challenge)!=0&& count($non_tech_area)!=0){
				$claim->technical 	= 	true;
			}else{
				$claim->technical 	= 	false;
			}

			if(count($staffCost)!=0 && count($EPWCost)!=0 && count($SubContractorsCosts)!=0 && count($costs)!=0){
				$claim->cost 		= 	true;
			}else{
				$claim->cost		= 	false;
			}		

			if(count($declaration)!=0){
				$claim->declaration	= 	true;
			}else{
				$claim->declaration	= 	false;
			}

				
				$staffCostTotal = array_map(function ($cost) {
					return ($cost['yearly_salary'] * $cost['per_R_D'])/100;
				}, $staffCost->toArray());		

				$EPWCostTotal = array_map(function ($cost) use ($settings) {
					return ($cost['yearly_salary'] * $cost['per_R_D'] * $settings->epw_cost)/100;
				}, $EPWCost->toArray());	
				
				$SubContractorsCostsTotal = array_map(function ($cost) use ($settings) {
					return ($cost['total_amount'] * $cost['per_attributed'] * $settings->epw_cost)/100;
				}, $SubContractorsCosts->toArray());	


				$costsTotal = array_map(function ($cost) use ($settings) {
					return ($cost['total_amount'] * $cost['per_attributed'] )/100;
				}, $costs->toArray());

	
			$claim->sme				= number_format(array_sum($staffCostTotal)+array_sum($EPWCostTotal)+array_sum($SubContractorsCostsTotal)+array_sum($costsTotal),2);
										
										
			$claim->projects		=	count($projectGet);
			$newArray[]				=	$claim;
		}						
		
					
		
		if(count($ClaimsGet) > 0){
			$data['message'] 		= 'Get Claims list';
			$data['status']			= true;
			$data['data']			= $ClaimsGet;
			$data['count']			= count($totalPages);
		}else {
			$data['message'] 	= 'Claims list not found';
			$data['status']		=  false;
			$data['data']		=  'No page found!';
			$data['count']		=  0;
		}
		return $data;
		
		
		
	}
	
	
	
	public function claimsDownloadAsCsv(Request $request,$claim_id)
    {
        $data 	= $request->all() ;
        $page 	= $data['page'];
        $limit 	= $data['limit']??5 ;

		
		$RolesGet		= DB::table('claims')->where('company_id',$claim_id)->orderBy('id', 'desc');
		
        if(!empty($limit)){
        	$RolesGet		= $RolesGet->limit($limit)->offset(($page) * $limit)->get();
        }
		else{
			$RolesGet		= $RolesGet->get();
		}
	// dd($RolesGet);die;
			$new_list=array();
	      if(count($RolesGet) > 0)
	      {
			$i=1;
			$settings 	= 	DB::table('settings')->first();
			foreach($RolesGet as $getClaimData){
				$claim_id				=	$getClaimData->id;
				$list					=	DB::table('reports')->Where('claim_id',$claim_id)->first();
				
				if(!empty($list)){
					$list_id			= base64_encode($list->id);
					$list_created_at	= $list->created_at;
					$list_status		= $list->status;
				}else{
					$list_status		=	2;
				}


				$getClientData			=	DB::table('client_company')->Where('company_id',$getClaimData->company_id)->first();
				$getUserData			=	DB::table('users')->Where('id',$getClientData->added_by)->first();
				$company_claims			=	DB::table('company_claims')->Where('claim_id',$claim_id)->first();
				// dd($company_claims->profit_loss);die;
				$projectGet 			=	DB::table('company_projects')->where('claim_id',$claim_id)
										->where('company_projects.project_status','Like','approved')
										->get();
				
				$commercial_goals		= 	DB::table('commercial_goals')->where('claim_id',$claim_id)->get();
				$aims 			  		= 	DB::table('aims')->where('claim_id',$claim_id)->get();
				$difficulties 			= 	DB::table('difficulties')->where('claim_id',$claim_id)->get();
				$technical_challenge 	= 	DB::table('technical_challenge')->where('claim_id',$claim_id)->get();
				$non_tech_area	 		= 	DB::table('non_tech_area')->where('claim_id',$claim_id)->get();

				$staffCost 				= 	DB::table('staff_costs')->where('claim_id',$claim_id)->get();
				$EPWCost				= 	DB::table('epw_costs')->where('claim_id',$claim_id)->get();
				$SubContractorsCosts 	= 	DB::table('subcontractors_costs')->where('claim_id',$claim_id)->get();
				$costs 					= 	DB::table('costs')->where('claim_id',$claim_id)->get();
				
				$declaration 			= 	DB::table('declaration')->where('claim_id',$claim_id)->get();
				

				
				$staffCostTotal = array_map(function ($cost) {
					return ($cost->yearly_salary * $cost->per_R_D)/100;
				}, $staffCost->toArray());		

				$EPWCostTotal = array_map(function ($cost) use ($settings) {
					return ($cost->yearly_salary * $cost->per_R_D * $settings->epw_cost)/100;
				}, $EPWCost->toArray());	
				
				$SubContractorsCostsTotal = array_map(function ($cost) use ($settings) {
					return ($cost->total_amount * $cost->per_attributed * $settings->epw_cost)/100;
				}, $SubContractorsCosts->toArray());	


				$costsTotal = array_map(function ($cost) use ($settings) {
					return ($cost->total_amount * $cost->per_attributed )/100;
				}, $costs->toArray());

	
										

				$new_list['Sr']					=	$i++;
				$new_list['client']				=	$getClientData->company_name;
				$new_list['incorporated_date']	=	$getClientData->incorporated_date;
				$new_list['incorporated_date']		=	date('d/m/Y', strtotime($new_list['incorporated_date']));
				$new_list['profit_or_loss']		=	$company_claims->profit_loss??'-';
				$new_list['report_number']		=	$list_id??'-';
				$new_list['report_date']		=	$list_created_at??"-";
				$new_list['reported_by']		=	!empty($list)?$getUserData->first_name.' '.$getUserData->last_name: '';
				
				if($list_status == 1){
					$new_list['report_status']	=	"Active";
				}elseif($list_status == 2){
					$new_list['report_status']	=	"-";
				}else{
					$new_list['report_status']	=	"In-Active";
				}
				
				if(!empty($company_claims)){
					$company_year_end_date	= $company_claims->year_end_date;
				}else{
					$company_year_end_date	= '';
				}
				

	

				if($company_year_end_date!=''){
					$new_list['claim_period'] = date('d/m/Y', strtotime($company_claims->year_end_date.' -1 year')).' - '.date('d/m/Y', strtotime($company_claims->year_end_date));
				}else{
					$new_list['claim_period'] = date('d/m/Y', strtotime($getClaimData->endDate.' -1 year')).' - '.date('d/m/Y', strtotime($getClaimData->endDate));
				}
				
				// $new_list['claim_period']			=	$company_claims->year_end_date." - ".date("Y-m-d",strtotime($company_claims->year_end_date.' -1 year'));
				$new_list['claim_status']			=	$getClaimData->status;
				$new_list['is_finalise']			=	!empty($list)?'Yes':'No';
				$new_list['year_end_date']		=	$company_claims->year_end_date??$getClaimData->endDate;
				$new_list['year_end_date']		=	date('d/m/Y', strtotime($new_list['year_end_date']));
				$new_list['invites']			=	count(DB::table('company_invites')->where('claim_id',$claim_id)->get());
				
				if(count($projectGet)>=1){
					$new_list['projects'] = 'Yes('.count($projectGet).')';
				}else{
					$new_list['projects'] = 'No('.count($projectGet).')';
				}
				
				if(count($staffCost)!=0 && count($EPWCost)!=0 && count($SubContractorsCosts)!=0 && count($costs)!=0){
					$new_list['cost'] 		= 	'Yes';
				}else{
					$new_list['cost']		= 	'No';
				}	
				
				if(count($commercial_goals)!=0 && count($aims)!=0 && count($difficulties)!=0 && count($technical_challenge)!=0&& count($non_tech_area)!=0){
					$new_list['technical'] 	= 	'Yes';
				}else{
					$new_list['technical'] 	= 	'No';
				}


				if(count($declaration)!=0){
					$new_list['declaration']	= 	'Yes';
				}else{
					$new_list['declaration']	= 	'No';
				}
				
				$new_list['sme_spend']		= number_format(array_sum($staffCostTotal)+array_sum($EPWCostTotal)+array_sum($SubContractorsCostsTotal)+array_sum($costsTotal),2);
				
				$new_list['paid']				=	$getClaimData->paid_status;
				
				unset($new_list['id']);
				unset($new_list['claim_id']);
				unset($new_list['status']);
				unset($new_list['created_at']);
				
				$newArray[]					=	$new_list;
			}
			// dd($newArray);die; 
		
	      	$data['message'] 	= 'List has been retrived';
	      	$data['status']		= true;
	      	$data['data']		= $newArray;
	      }else {
	      	$data['message'] 	= 'no list not found';
	      	$data['status']		=  false;
	      	$data['data']		=  '';
	      	$data['count']		=  0;
	      }
	      return $data;
    }
	
	public function getAllClaimsOld(Request $request,$company_id)
	{	
		$page = $request->input('page')??0 ;
        $limit = $request->input('limit')??1;
        $filter = $request->input('filter');
        $sortField = $request->input('sortField')??'id';
        $sortOrder = $request->input('sortOrder')??'desc';


        if(!empty($limit) || !empty($sortOrder))
        {	
        	if((!empty($filter) && !empty($sortField) && !empty($sortOrder)))
        	{  
        		$ClaimsGet	= 	Claims::where('company_id',$company_id)
								->leftJoin('company_claims','claims.id','=','company_claims.claim_id')
								->limit($limit)
        						->offset(($page) * $limit)
        						->orderBy('claims.id', $sortOrder)
								->get();

				$projectGet = DB::table('company_projects')->where('claim_id',$ClaimsGet[0]['id'])
    							->where('company_projects.project_status','Like','approved')
    							->get();

				$totalPages		= count($ClaimsGet);
        	}
    		if(!empty($limit) || !empty($page))
    		{ 
    			$ClaimsGet	= Claims::where('company_id',$company_id)
								->leftJoin('company_claims','claims.id','=','company_claims.claim_id')
								->limit($limit)
        						->offset(($page) * $limit)
    							->get();

    			$projectGet = DB::table('company_projects')->where('claim_id',$ClaimsGet[0]['id'])
    							->where('company_projects.project_status','Like','approved')
    							->get();

    			$totalPages		= count($ClaimsGet);
    		}
        	else{   	
        		$ClaimsGet	= Claims::where('company_id',$company_id)
								->leftJoin('company_claims','claims.id','=','company_claims.claim_id')
								->get();

				$projectGet = DB::table('company_projects')->where('claim_id',$ClaimsGet[0]['id'])
    							->where('company_projects.project_status','Like','approved')
    							->get();

        		$totalPages		= count($ClaimsGet);
        	}
			
			
        }
		else{
			$ClaimsGet		= Claims::where('company_id',$company_id)
								->leftJoin('company_claims','claims.id','=','company_claims.claim_id')
								->orderBy('id', 'desc')->get();
								
			$projectGet = DB::table('company_projects')->where('claim_id',$ClaimsGet[0]['id'])
    							->where('company_projects.project_status','Like','approved')
    							->get();

			$totalPages		= count($ClaimsGet);
		}

		$claim_id = $ClaimsGet[0]['id'];

		// check if STaff cost section is completed
		$staffCost = StaffCosts::where('claim_id',$claim_id)->get();
		$CostCal = 0;
		$Staffsum = 0;
		foreach ($staffCost as $cost) {

			$CostCal = (($cost->yearly_salary * $cost->per_R_D)/100); 
			$Staffsum += $CostCal;
		}
		
		$totlastaffCost = $Staffsum; // Total Staff Costs
		
		$EPWCost = EPWCosts::where('claim_id',$claim_id)->get();
		$EPWCostCal = 0;
		$EPWsum = 0;
		foreach ($EPWCost as $EPW) {

			$EPWCostCal = (($EPW->yearly_salary * $EPW->per_R_D)/100); 
			$EPWsum += $EPWCostCal;
		}
		
		$totlasEPWCost = $EPWsum; // Total EPW Costs

		$SubContractorsCosts = SubContractorsCosts::where('claim_id',$claim_id)->get();
		$SubContractorsCostCal = 0;
		$SubContractorssum = 0;
		foreach ($SubContractorsCosts as $SubContractors) {

			$SubContractorsCostCal = (($SubContractors->yearly_salary * $SubContractors->per_R_D)/100); 
			$SubContractorssum += $SubContractorsCostCal;
		}
		
		$totlasSubContractorsCost = $SubContractorssum; // Total SubContractors Costs

		$costs = Costs::where('claim_id',$claim_id)->get();
		$costsCostCal = 0;
		$costssum = 0;
		foreach ($costs as $cost) {

			$costsCostCal = (($cost->total_amount * $cost->per_attributed	)/100); 
			$costssum += $costsCostCal;
		}
		
		$totlascostsCost = $costssum; // Total SubContractors Costs

		$finalSum = $totlastaffCost + $totlasEPWCost + $totlasSubContractorsCost + $totlascostsCost ; // Total of Staff Costs

		if(count($staffCost)!=0 && count($EPWCost)!=0 && count($SubContractorsCosts)!=0 && count($costs)!=0)
		{
			$cost_count = true;
		}
		else{
			$cost_count = false;
		}

		// check if Technical section is completed
		$commercial_goals		= DB::table('commercial_goals')->where('claim_id',$claim_id)->get();
		$aims 			  		= DB::table('aims')->where('claim_id',$claim_id)->get();
		$difficulties 			= DB::table('difficulties')->where('claim_id',$claim_id)->get();
		$technical_challenge 	= DB::table('technical_challenge')->where('claim_id',$claim_id)->get();
		$non_tech_area	 		= DB::table('non_tech_area')->where('claim_id',$claim_id)->get();

		if(count($commercial_goals)!=0 && count($aims)!=0 && count($difficulties)!=0 && count($technical_challenge)!=0&& count($non_tech_area)!=0)
		{
			$technical_count = true;
		}
		else{
			$technical_count = false;
		}

					
	      if(count($ClaimsGet) > 0)
	      {
	      	$data['message'] 		= 'Get Claims list';
	      	$data['status']			= true;
	      	$data['data']			= $ClaimsGet;
	      	$data['count']			= $totalPages;
	      	$data['project_data']	= $projectGet;	      	
			$data['projects_count']	= count($projectGet);
			$data['costs'] 			= $cost_count;
			$data['technical'] 		= $technical_count;
			$data['total_SME'] 		= $finalSum;
	      	//$data['user_role']		= $UserRole->role_name;
	      }else {
	      	$data['message'] 	= 'Claims list not found';
	      	$data['status']		=  false;
	      	$data['data']		=  'No page found!';
	      	$data['count']		=  0;
	      }
	      return $data;		
	}
	/*
	* Function to get Claims
	*/
	public function getClaim($claim_id)
	{
		$claimCheck = $this->claimCheck($claim_id);
		if(empty($claimCheck))
		{
			$data['message'] = 'Claim Not Found!';
			$data['status'] = false;

			return $data; die;
		}

		$getClaim 			= Claims::where('id',$claim_id)->first();
		$getClient 			= CompanyDetails::where('company_id',$getClaim->company_id)->first();
		$getCompanyClaim 	= CompanyClaims::where('claim_id',$claim_id)->first();
		if(!empty($getCompanyClaim)){
			$getCompanyClaim->show_year_end_date 	= 	date("d/m/Y",strtotime($getCompanyClaim->year_end_date));
		}
		$getCompanyAbout 	= ClaimAbout::where('claim_id',$claim_id)->first();
		$getNotes 			= CaseNotes::where('claim_id',$claim_id)->get();
		$getInvites 		= Invites::where('claim_id',$claim_id)->get();
		$getProjects 		= DB::table('company_projects')->select(DB::raw('*,project_type as type,project_status as status,project_summary as summary'))->where('claim_id',$claim_id)->get();

		// check if STaff cost section is completed
		$staffCost = StaffCosts::where('claim_id',$claim_id)->get();
		$CostCal = 0;
		$sum = 0;
		/*echo '<pre>';
			print_r($staffCost);*/

		/*foreach ($staffCost as $cost) {
			
			$CostCal = (($cost->yearly_salary * $cost->per_R_D)/100); 

			$sum += $costCal;
		}

		echo 'sum'+$sum;*/
		//die;
		$EPWCost = EPWCosts::where('claim_id',$claim_id)->get();
		$SubContractorsCosts = SubContractorsCosts::where('claim_id',$claim_id)->get();
		$costs = Costs::where('claim_id',$claim_id)->get();

		if(count($staffCost)!=0 && count($EPWCost)!=0 && count($SubContractorsCosts)!=0 && count($costs)!=0)
		{
			$cost_count = true;
		}
		else{
			$cost_count = false;
		}

		// check if Technical section is completed
		$commercial_goals		= DB::table('commercial_goals')->where('claim_id',$claim_id)->get()->first();
		$aims 			  		= DB::table('aims')->where('claim_id',$claim_id)->get()->first();
		$difficulties 			= DB::table('difficulties')->where('claim_id',$claim_id)->get();
		$technical_challenge 	= DB::table('technical_challenge')->where('claim_id',$claim_id)->get()->first();
		$non_tech_area	 		= DB::table('non_tech_area')->where('claim_id',$claim_id)->get();

		// if(count($commercial_goals)!=0 && count($aims)!=0 && count($difficulties)!=0 && count($technical_challenge)!=0&& count($non_tech_area)!=0)
		// {
			// $technical_count = true;
		// }
		// else{
			$technical_count = false;
		// }
		
		$raw 		= Costs::where('claim_id',$claim_id)
					->where('expenditure','raw-material')
					->get()->first();
		$utilities 	= Costs::where('claim_id',$claim_id)
					->where('expenditure','utilities')
					->get()->first();	
		$software 	= Costs::where('claim_id',$claim_id)
					->where('expenditure','software')
					->get()->first();
		$reimbursed = Costs::where('claim_id',$claim_id)
					->where('expenditure','reimbursed')
					->get()->first();


		if($getClaim)
		{
			$data['message'] 		= 'Claim is retrived!';
			$data['status'] 		= true;
			$data['client_data'] 	= $getClient;
			$data['claim_data'] 	= $getClaim;
			$data['company_claim'] 	= $getCompanyClaim;
			$data['company_about'] 	= $getCompanyAbout;
			$data['case_notes'] 	= $getNotes;
			$data['invites'] 		= $getInvites;
			$data['projects'] 		= $getProjects;
			$data['staff_cost'] 	= $staffCost;
			$data['EPWCost'] 		= $EPWCost;
			$data['SubContractorsCosts'] 		= $SubContractorsCosts;
			$data['costs'] 			= $costs;
			$data['projects'] 		= $getProjects;
			$data['projects_count']	= count($getProjects);
			$data['costs'] 			= $cost_count;
			$data['technical'] 		= $technical_count;
			$data['raw'] 			= $raw;
			$data['utilities'] 		= $utilities;
			$data['software'] 		= $software;
			$data['reimbursed'] 	= $reimbursed;
			$data['commercial_goals'] 		= $commercial_goals;
			$data['aims'] 					= $aims;
			$data['technical_challenge'] 	= $technical_challenge;
		}
		else{
			$data['message'] = 'Something went wrong';
			$data['status'] = false;
		}
		return $data;
	}
	/*
	* Function to add Company Basics
	*/
	public function addCompanyBasics(Request $request,$claim_id)
	{	
		$claimCheck = $this->claimCheck($claim_id);
		if(empty($claimCheck))
		{
			$data['message'] = 'Claim Not Found!';
			$data['status'] = false;

			return $data; die;
		}
		$requestData = $request->input();

		$number_of_directors 	= 	 $requestData['number_of_directors'];
        $number_of_staff 		=    $requestData['number_of_staff'];      
        // check if date is validated or not 
		$year_end_date 			= 	 date("Y-m-d", strtotime($requestData['year_end_date']));
        $profit_loss 			=    $requestData['profit_loss'];
        $turnover 				=    $requestData['turnover'];
        $gross_balance_sheet 	=    $requestData['gross_balance_sheet'];
        $grants 				=    $requestData['grants'];
        $property_ownership 	=    $requestData['property_ownership'];
        $part_of_group 			=    $requestData['part_of_group'];
        $name_of_group 			=    $requestData['name_of_group'];
        $percentage_own 		=    $requestData['percentage_own'];
        $created_at				= 	 date('Y-m-d H:i:s');

        $company_reg 			= 	 $requestData['company_reg'];
        $incorporated_date	 	= 	 $requestData['incorporated_date'];
        $directory_name		 	= 	 $requestData['directory_name'];
        $email 					= 	 $requestData['email'];
        $phone 					= 	 $requestData['phone'];

        // Update Company details

        $comArr = array(
        	'email' => $email ,	
        	'phone' => $phone ,
        	'company_reg' => $company_reg,
        	'directory_name' => $directory_name,
        	'incorporated_date' => $incorporated_date,
        );

        // Get claim company ID

        $comGet = Claims::where('id',$claim_id)->first();
        $updateCom = CompanyDetails::where('company_id',$comGet->company_id)->update($comArr);

        // insert data into database
		
		 CompanyClaims::where('claim_id',$claim_id)->delete();

        $companyArr = array(
        	'claim_id'				=>	  $claim_id,
        	'number_of_directors' 	=> 	  $number_of_directors,
	        'number_of_staff' 		=>    $number_of_staff,
	        'year_end_date' 		=>    $year_end_date,
	        'profit_loss' 			=>    $profit_loss,
	        'turnover' 				=>    $turnover,
	        'gross_balance_sheet' 	=>    $gross_balance_sheet,
	        'grants' 				=>    $grants,
	        'property_ownership' 	=>    $property_ownership,
	        'part_of_group'			=>    $part_of_group,
	        'created_at'			=>	  $created_at,
        ); 
        $comBasics = CompanyClaims::insertGetId($companyArr);

        if($part_of_group == 1)
        {
        	$partArr = array(
        		'name_of_group'			=>    $name_of_group,
        		'percentage_own'		=>    $percentage_own,
        	);

        	$partUpdate = CompanyClaims::where('cid',$comBasics)->update($partArr);
        }

        $claimsGet = CompanyClaims::where('cid',$comBasics)->first();
        if(isset($comBasics))
        {
			
		$data['company_basics']  = 'true';
		$this->updateClaimProgressPrivate($data,$claim_id);
			
		$notes = $requestData['notes'];
		if(!empty($notes)){
			$created_at = date('Y-m-d H:i:s');
			foreach ($notes as $note) {

				$notesArr[] = array(
					'claim_id'		=>	$claim_id,
					'case_notes'	=>	$note['notes'],
					'created_by'	=>	$note['createdBy'],
					'created_at'	=>	$created_at
				); 
			}
			$notesInsert = CaseNotes::insert($notesArr);
		}
			
			
        	$data['message'] = 'Company information updated successfully!';
        	$data['status'] = true;
        	$data['claim_data'] = $claimsGet;
        }
        else{
        	$data['message'] = 'Something went wrong';
        	$data['status'] = false;
        }

        return $data;
	}

	/*
	* Function to check if claim exists or not
	*/

	protected function claimCheck($claim_id)
	{
		return Claims::where('id',$claim_id)->first();
	}
	/*
	* Function to add Company Case Notes
	*/

	public function addCompanyCase(Request $request,$claim_id)
	{
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}
		$requestData = $request->input();

		$notes = json_decode($requestData['notes'],true);
		
		$created_at = date('Y-m-d H:i:s');
		foreach ($notes as $note) {

			$notesArr[] = array(
				'claim_id'		=>	$claim_id,
				'case_notes'	=>	$note['notes'],
				'created_by'	=>	$note['createdBy'],
				'created_at'	=>	$created_at
			); 
		}
			$notesInsert = CaseNotes::insert($notesArr);
		

		if($notesInsert)
		{
			$data['message'] = 'Case Notes inserted successfully!';
			$data['status'] = true;
		}
		else{
			$data['message'] = 'Something went wrong';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to check if case exists or not 
	*/
	protected function caseCheck($case_id)
	{
		return CaseNotes::where('case_id',$case_id)->first();
	}

	/*
	* Function to delete case Notes
	*/
	public function deleteCase($case_id)
	{	
		$checkCase = $this->caseCheck($case_id);
		if(empty($checkCase))
		{
			$data['message'] = 'Case Not found!';
			$data['status'] = false;

			return $data; die;
		}
		$delCase = CaseNotes::where('case_id',$case_id)->delete();

		if($delCase)
		{
			$data['message'] = 'Case Notes is deleted successfully!';
			$data['status'] = true;
		}
		else{
			$data['message'] ='Something went wrong!';
			$data['status']	= false;
		}

		return $data;
	}

	/*
	* Function to get About company
	*/
	public function getAbout($claim_id)
	{
		$aboutGet = ClaimAbout::where('claim_id',$claim_id)->first();
		$getCompany = CompanyClaims::where('claim_id',$claim_id)->first();
		if($aboutGet)
		{
			$data['message'] ='About information retrived successfully!';
			$data['status'] = true;
			$data['about_data'] = $aboutGet;
			$data['company_data'] = $getCompany;
		}
		else{
			$data['message'] ='Something went wrong';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to Add Company about
	*/
	public function aboutCompany(Request $request,$claim_id)
	{	
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$about_us = $requestData['about_us'];
		$created_at = date('Y-m-d H:i:s');

		$aboutArr = array(
			'claim_id' => $claim_id,
			'about' => $about_us,
			'created_at' => $created_at
		);

		 ClaimAbout::where('claim_id',$claim_id)->delete(); // delete if already exists
		$aboutAdd = ClaimAbout::insertGetId($aboutArr);
		$aboutGet = ClaimAbout::where('claim_id',$claim_id)->first();
		if($aboutAdd)
		{
			$data['about']  		= 'true';
			$this->updateClaimProgressPrivate($data,$claim_id);
			
			$data['message'] ='About information updated successfully!';
			$data['status'] = true;
			$data['about_data'] = $aboutGet;
		}
		else{
			$data['message'] ='Something went wrong';
			$data['status'] = false;
		}

		return $data;
	}
	/*
	* Check for the about id
	*/
	protected function checkAbout($about_id)
	{
		return ClaimAbout::where('about_id',$about_id)->first();
	}

	/*
	* Function to Edit Company about
	*/
	public function editaboutCompany(Request $request,$about_id)
	{	
		$checkAbout = $this->checkAbout($about_id);
		if(empty($checkAbout))
		{
			$data['message'] = 'About data Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$about_us = $requestData['about_us'];
		$updated_at = date('Y-m-d H:i:s');

		$aboutArr = array(
			'about' => $about_us,
			'updated_at' => $created_at
		);
		$aboutAdd = ClaimAbout::where('about_id',$about_id)->update($aboutArr);
		$aboutGet = ClaimAbout::where('about_id',$about_id)->first();

		if($aboutAdd)
		{
			$data['message'] ='About information updated successfully!';
			$data['status'] = true;
			$data['about_data'] = $aboutGet;
		}
		else{
			$data['message'] ='Something went wrong';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to add Projects
	*/
	public function addProject(Request $request,$claim_id)
	{
		$projects = $request['projects'];
		
		$created_at = date('Y-m-d H:i:s');
		foreach ($projects as $project) {

			$projectArr[] = array(
				'claim_id'		=> $claim_id,
				'project_type'			=> $project['project_type'],
				'project_status'		=> $project['project_status'],
				'project_summary'		=> $project['project_summary'],
				'created_at'	=> $created_at,
			); 
		}
		
		$res = DB::table('company_projects')->insert($projectArr);
		
		if($res){
			$projects 				= DB::table('company_projects')->where('claim_id',$claim_id)->get();
			$data['message'] 		= 'projects data have been added!';
			$data['status']  		= true;
			$data['data'] 			= $projects;
		}
		else{
			$data['message']	= 'Something went wrong!';
			$data['status']		= false;
		}

		return $data;
		
	}		
	
	
		/*
	* Function to update Project
	*/
	public function editProject(Request $request,$project_id)
	{
		$updated_at = date('Y-m-d H:i:s');

		$upArr = array(
			'project_type'			=> $request['project_type'],
			'project_status'		=> $request['project_status'],
			'project_summary'		=> $request['project_summary'],
			'modified_at'	=> $updated_at,
		);

		$editInvite = DB::table('company_projects')->where('id',$project_id)->update($upArr);

		if($editInvite)
		{
			$data['message'] = 'Updated successfully!';
			$data['status'] = true;
		}
		else{
			$data['message'] = 'Something went wrong';
			$data['status'] = true;
		}

		return $data;
	}
	
	
	
		/*
	* Function to delete project
	*/

	public function deleteProject(Request $request,$project_id)
	{
		$del = DB::table('company_projects')->where('id',$project_id)->delete();

		if($del)
		{
			$data['message'] = 'Project deleted Successfully!';
			$data['status'] = true;
		}
		else{
			$data['message'] = 'Something went wrong';
			$data['status'] = false;
		}

		return $data;
	}
	
	/*
	* Function to add Invites
	*/
	public function getInvites(Request $request,$claim_id)
	{
		$requestData = $request->input();

		$invite_id	='';
		$created_at	= date('Y-m-d H:i:s');
		

		$invites = $requestData['invites'];
		
		$created_at = date('Y-m-d H:i:s');
		foreach ($invites as $invite) {
			
		if(in_array('Projects',$invite['roles'])){
			$permission['projects'] = true;	
		}else{
			$permission['projects'] = false;	
		}
		
		if(in_array('Costs',$invite['roles'])){
			$permission['staffCosts'] = true;	
			$permission['epwCosts'] = true;	
			$permission['subcontractorCosts'] = true;	
			$permission['consumableCosts'] = true;	
			$permission['softwareCosts'] = true;	
			$permission['expenses'] = true;	
		}else{
			$permission['staffCosts'] = false;	
			$permission['epwCosts'] = false;	
			$permission['subcontractorCosts'] = false;	
			$permission['consumableCosts'] = false;	
			$permission['softwareCosts'] = false;	
			$permission['expenses'] = false;	
		}
		
		if(in_array('Technical',$invite['roles'])){
			$permission['commercialGoals'] = true;	
			$permission['aims'] = true;	
			$permission['difficulties'] = true;	
			$permission['technicalChallenges'] = true;	
			$permission['nonTechAreas'] = true;	
		}else{
			$permission['commercialGoals'] = false;	
			$permission['aims'] = false;	
			$permission['difficulties'] = false;	
			$permission['technicalChallenges'] = false;	
			$permission['nonTechAreas'] = false;		
		}
		
		if(in_array('Declaration & T&C',$invite['roles'])){
			$permission['declaration'] = true;	

		}else{
			$permission['declaration'] = false;		
		}
			$token			=		 md5(uniqid(rand(), true));
			$inviteArr = array(
				'invite_token'	=>$token,
				'claim_id'		=> $claim_id,
				'user_id'		=> $requestData['user_id'],
				'client_id'		=> $requestData['client_id'],
				'invite_name'	=> $invite['name'],
				'invite_email'	=> $invite['email'],
				'invite_roles'	=> implode(',',$invite['roles']),
				'created_at'	=> $created_at,
			); 

			$invite_id = Invites::insertGetId($inviteArr);
			if(!empty($invite_id)){
				
				foreach($permission as $key=>$val){
					$permissionArr[] = array(
						'invite_id' 	=> 	$invite_id,
						'permission_key' 			=> 	$key,
						'permission_value'			=>	$val,
					);
				}
				// dd($permissionArr);die;
				DB::table('company_invite_permissions')->insert($permissionArr);

			}
			
			$settings 	= 	DB::table('settings')->first();
			
			
			// Send email code
		
			$to_email = $invite['email'];

			$getTemplate = EmailTemplates::where('email_id',4)->first(); // get template info
			$getCompany = CompanyClaims::where('claim_id',$claim_id)->first(); // get template info

			$fullName = ucfirst($invite['name']);
			$body = $getTemplate->body;
			$subject = $getTemplate->subject;
			$path = config('app.url').'claims/company-basics/'.$token;
			$endDate =  $getCompany->year_end_date;
			
			$logo = URL::to('/images/'.$settings->logo);

			$finalBody =  str_replace(['#dearStr#','#btnLink#','#endDate#','#logo#','#baseUrl#'], [$fullName,$path,$endDate,$logo,config('app.url')], $body );

			Mail::send([], [], function($message) use ($fullName, $to_email,$subject,$finalBody) {
				$message->from('info@creditool.co.uk','Creditool');
				$message->to($to_email);
				$message->subject($subject);
				$message->setBody($finalBody, 'text/html');
			});
			
			
		}
		
		if($invite_id)
		{
			$getInvite = Invites::where('claim_id',$claim_id)->get();
			$data['message'] 		= 'Invitation sent!';
			$data['status']  		= true;
			$data['invite_data'] 	= $getInvite;
		}
		else{
			$data['message']	= 'Something went wrong!';
			$data['status']		= false;
		}

		return $data;
		
	}

	/*
	* Check if Invite ID Exists or not
	*/

	protected function checkInvite($invite_id)
	{
		return Invites::where('invite_id',$invite_id)->first();
	}	
	
	/*
	* Check invite token n return data
	*/
	
	protected function updateInviteTokenStatus(Request $request,$id)
	{
		$upInviteArr = array('status'	=> 	0);
		$editInvite = Invites::where('invite_id',$id)->update($upInviteArr);
		$result['message'] 	= 'Token update successfully';
		$result['status'] 	= true;
		return $result;
	}

	protected function checkInviteToken(Request $request,$token)
	{
		$data = Invites::where('invite_token',$token)->where('status',1)->first();
		if(!empty($data)){
			$permission = DB::table('company_invite_permissions')->where('invite_id',$data['invite_id'])->get();
			if(!empty($permission)){
				
				$upInviteArr = array(
					'status'		=> 0
				);

				// $editInvite = Invites::where('invite_id',$data->invite_id)->update($upInviteArr);
				
				
				$users 		= 	User::where('id',$data['user_id'])->first();
				$userToken	=	JWTAuth::fromUser($users);
				if(!empty($userToken)){
					$data['api_token']				= $userToken;
					$result['message'] 				= 'Data retrieved successfully';
					$result['status'] 				= true;
					$result['data'] 				= $data;
					$result['data']['permission'] 	= $permission;
				}else{
					$result['message'] 	= 'Token does not exit!';
					$result['status'] 	= false;
				}
			}else{
				$result['message'] 	= 'Token mismatch or does not exit!';
				$result['status'] 	= false;
			}
		}else{
			$result['message'] 	= 'Token mismatch or expired!';
			$result['status'] 	= false;
		}
		return $result;
	}	
	
	/*
	* Get invite by id
	*/

	protected function getInviteData(Request $request,$id)
	{
		$data = Invites::where('invite_id',$id)->first();
		if(!empty($data)){
			$permission = DB::table('company_invite_permissions')->where('invite_id',$data['invite_id'])->get();
			if(!empty($permission)){
				$result['message'] 				= 'Data retrieved successfully';
				$result['status'] 				= true;
				$result['data'] 				= $data;
				$result['data']['permission'] 	= $permission;
			}else{
				$result['message'] 	= 'Token mismatch or does not exit!';
				$result['status'] 	= false;
			}
		}else{
			$result['message'] 		= 'Token mismatch or does not exit!';
			$result['status'] 		= false;
		}
		return $result;
	}

	/*
	* Function to update invite
	*/
	public function editInvite(Request $request,$invite_id)
	{
		$InviteCheck = $this->checkInvite($invite_id);
		$updated_at = date('Y-m-d H:i:s');

		if(empty($InviteCheck))
		{
			$data['message'] = 'Invite not found!';
			$data['status'] = false;

			return $data; die;
		}
		$upInviteArr = array(
			'invite_name'	=> $invite['name'],
			'invite_email'	=> $invite['email'],
			'invite_roles'	=> implode(',',$invite['roles']),
			'updated_at'	=> $updated_at,
		);

		$editInvite = Invites::where('invite_id',$invite_id)->update($upInviteArr);

		if($editInvite)
		{
			$data['message'] = 'Updated successfully!';
			$data['status'] = true;
		}
		else{
			$data['message'] = 'Something went wrong';
			$data['status'] = true;
		}

		return $data;
	}

	/*
	* Function to delete Invite Sent
	*/

	public function deleteInvite(Request $request,$invite_id)
	{
		$delInvite = Invites::where('invite_id',$invite_id)->delete();

		if($delInvite)
		{
			DB::table('company_invite_permissions')->where('invite_id',$invite_id)->delete();
			// Invites::where('invite_id',$invite_id)->delete();
			$data['message'] = 'Invite deleted Successfully!';
			$data['status'] = true;
		}
		else{
			$data['message'] = 'Something went wrong';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to add Staff Costs
	*/

	public function addStaffCosts(Request $request,$claim_id)
	{
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$staff_name = $requestData['staff_name'];
		$yearly_salary = $requestData['yearly_salary'];
		$per_R_D = $requestData['per_R_D'];
		$created_at = date('Y-m-d H:i:s');

		$costsArr= array(
			'claim_id' =>$claim_id,
			'staff_name' => $staff_name,
			'yearly_salary' => $yearly_salary,
			'per_R_D' => $per_R_D,
			'created_at' =>$created_at
		);

		$costsAdd = StaffCosts::insertGetId($costsArr);

		$getCosts = StaffCosts::where('costs_id',$costsAdd)->first();

		if($getCosts)
		{
			$data['message'] = 'Staff Costs added successfully!';
			$data['status'] = true;
			$data['staff_cost_data'] = $getCosts;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to get the list of Staff costs
	*/
	public function ViewStaffCosts($claim_id)
	{
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$getCosts = StaffCosts::where('claim_id',$claim_id)->get();
		$getCompany = CompanyClaims::where('claim_id',$claim_id)->first();

		if(count($getCosts) != 0 )
		{
			$data['message'] = 'Staff Costs information retrived successfully!';
			$data['status'] = true;
			$data['costs_data'] = $getCosts;
			$data['company_data'] = $getCompany;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}
		return $data;
	}

	/*
	* Function to get  the data by costID
	*/
	public function viewCosts($cost_id)
	{
		$checkID = $this->checkCostID($cost_id);
		if(empty($checkID))
		{
			$data['message'] = 'Staff Costs does not exists';
			$data['status'] = false;
			return $data; die;

		}

		$getCost =  StaffCosts::where('costs_id',$cost_id)->first();
		// $getCompany = CompanyClaims::where('claim_id',$claim_id)->first();

		if($getCost)
		{
			$data['message'] = ' Cost information retrived successfully!';
			$data['status'] = true;
			$data['cost_data'] = $getCost;
			// $data['company_data'] = $getCompany;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Check if Cost ID exists or not 
	*/
	protected function checkCostID($cost_id)
	{
		return StaffCosts::where('costs_id',$cost_id)->first();
	}

	/*
	* Function to edit the Staff Costs
	*/
	public function editStaffCosts(Request $request,$cost_id)
	{
		$requestData = $request->input();

		$checkID = $this->checkCostID($cost_id);
		if(empty($checkID))
		{
			$data['message'] = 'Staff Costs does not exists';
			$data['status'] = false;
			return $data; die;

		}
		$staff_name = $requestData['staff_name'];
		$yearly_salary = $requestData['yearly_salary'];
		$per_R_D = $requestData['per_R_D'];
		$updated_at = date('Y-m-d H:i:s');

		$costsArr= array(
			'staff_name' => $staff_name,
			'yearly_salary' => $yearly_salary,
			'per_R_D' => $per_R_D,
			'updated_at' =>$updated_at
		);

		$costsAdd = StaffCosts::where('costs_id',$cost_id)->update($costsArr);

		$getCosts = StaffCosts::where('costs_id',$cost_id)->first();

		if($getCosts)
		{
			$data['message'] = 'Staff Costs updated successfully!';
			$data['status'] = true;
			$data['staff_cost_data'] = $getCosts;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to delete Staff Costs
	*/
	public function deleteStaffCosts($cost_id)
	{	

		$checkID = $this->checkCostID($cost_id);
		if(empty($checkID))
		{
			$data['message'] = 'Staff Costs does not exists';
			$data['status'] = false;
			return $data; die;

		}

		$delCosts = StaffCosts::where('costs_id',$cost_id)->delete();

		if($delCosts)
		{
			$data['message'] = 'Staff Costs data deleted successfully!';
			$data['status'] = true;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}
	/*
	* Function to add EPW Costs
	*/
	public function addEPWCosts(Request $request,$claim_id)
	{
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$staff_name = $requestData['staff_name'];
		$yearly_salary = $requestData['yearly_salary'];
		$per_R_D = $requestData['per_R_D'];
		$created_at = date('Y-m-d H:i:s');

		$costsArr= array(
			'claim_id' =>$claim_id,
			'staff_name' => $staff_name,
			'yearly_salary' => $yearly_salary,
			'per_R_D' => $per_R_D,
			'created_at' =>$created_at
		);

		$costsAdd = EPWCosts::insertGetId($costsArr);

		$getCosts = EPWCosts::where('epw_id',$costsAdd)->first();

		if($getCosts)
		{
			$data['message'] = 'EPW Costs added successfully!';
			$data['status'] = true;
			$data['staff_cost_data'] = $getCosts;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Check if Cost ID exists or not 
	*/
	protected function checkEPWCostID($cost_id)
	{
		return EPWCosts::where('epw_id',$cost_id)->first();
	}

	/*
	* Function to edit the Staff Costs
	*/
	public function editEPWCosts(Request $request,$cost_id)
	{
		$requestData = $request->input();

		$checkID = $this->checkEPWCostID($cost_id);
		if(empty($checkID))
		{
			$data['message'] = 'EPW Costs does not exists';
			$data['status'] = false;
			return $data; die;

		}
		$staff_name = $requestData['staff_name'];
		$yearly_salary = $requestData['yearly_salary'];
		$per_R_D = $requestData['per_R_D'];
		$updated_at = date('Y-m-d H:i:s');

		$costsArr= array(
			'staff_name' => $staff_name,
			'yearly_salary' => $yearly_salary,
			'per_R_D' => $per_R_D,
			'updated_at' =>$updated_at
		);

		$costsAdd = EPWCosts::where('epw_id',$cost_id)->update($costsArr);

		$getCosts = EPWCosts::where('epw_id',$cost_id)->first();

		if($getCosts)
		{
			$data['message'] = 'EPW Costs updated successfully!';
			$data['status'] = true;
			$data['epw_cost_data'] = $getCosts;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to delete Staff Costs
	*/
	public function deleteEPWCosts($cost_id)
	{	

		$checkID = $this->checkEPWCostID($cost_id);
		if(empty($checkID))
		{
			$data['message'] = 'EPW Costs does not exists';
			$data['status'] = false;
			return $data; die;

		}

		$delCosts = EPWCosts::where('epw_id',$cost_id)->delete();

		if($delCosts)
		{
			$data['message'] = 'EPW Costs data deleted successfully!';
			$data['status'] = true;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to get the list of Staff costs
	*/
	public function ListEPWCosts($claim_id)
	{
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$getCosts = EPWCosts::where('claim_id',$claim_id)->get();
		$getCompany = CompanyClaims::where('claim_id',$claim_id)->first();

		if(count($getCosts) != 0 )
		{
			$data['message'] = 'EPW Costs information retrived successfully!';
			$data['status'] = true;
			$data['costs_data'] = $getCosts;
			$data['company_data'] = $getCompany;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}
		return $data;
	}

	/*
	* Function to get  the data by costID
	*/
	public function viewEPWCosts($cost_id)
	{
		$checkID = $this->checkEPWCostID($cost_id);
		if(empty($checkID))
		{
			$data['message'] = 'EPW Costs does not exists';
			$data['status'] = false;
			return $data; die;

		}

		$getCost =  EPWCosts::where('epw_id',$cost_id)->first();
		// $getCompany = CompanyClaims::where('claim_id',$claim_id)->first();

		if($getCost)
		{
			$data['message'] = ' Cost information retrived successfully!';
			$data['status'] = true;
			$data['cost_data'] = $getCost;
			// $data['company_data'] = $getCompany;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to add Subcontractors Costs
	*/

	public function addSubCosts(Request $request,$claim_id)
	{
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$total_amount = $requestData['total_amount'];
		$per_attributed = $requestData['per_attributed'];
		$description = $requestData['description'];
		$created_at = date('Y-m-d H:i:s');

		$addArr = array(
			'claim_id' =>$claim_id,
			'total_amount' => $total_amount,
			'per_attributed' => $per_attributed,
			'description' => $description,
			'created_at' =>$created_at
		);

		$addSubData = SubContractorsCosts::insertGetId($addArr);

		$getData = SubContractorsCosts::where('sc_id',$addSubData)->first();

		if($getData)
		{
			$data['message'] = 'Sub Contractors Costs added successfully!';
			$data['status'] = true;
			$data['subcontractors_data'] = $getData;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to check if subcontractors_id exists or not
	*/
	protected function checkSubCont_id($subcontractors_id)
	{
		return SubContractorsCosts::where('sc_id',$subcontractors_id)->first();
	}

	/*
	* Function to add Subcontractors Costs
	*/

	public function editSubCosts(Request $request,$subcontractors_id)
	{
		$checkSubCont_id = $this->checkSubCont_id($subcontractors_id);
		if(empty($checkSubCont_id))
		{
			$data['message'] = 'Subcontractors_id Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$total_amount = $requestData['total_amount'];
		$per_attributed = $requestData['per_attributed'];
		$description = $requestData['description'];
		$updated_at = date('Y-m-d H:i:s');

		$addArr = array(
			'total_amount' => $total_amount,
			'per_attributed' => $per_attributed,
			'description' => $description,
			'updated_at' =>$updated_at
		);

		$addSubData = SubContractorsCosts::where('sc_id',$subcontractors_id)->update($addArr);

		$getData = SubContractorsCosts::where('sc_id',$subcontractors_id)->first();

		if($getData)
		{
			$data['message'] = 'Sub Contractors Costs updated successfully!';
			$data['status'] = true;
			$data['subcontractors_data'] = $getData;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to delete subsontractors
	*/
	public function deleteSubCosts($subcontractors_id)
	{
		$checkSubCont_id = $this->checkSubCont_id($subcontractors_id);
		if(empty($checkSubCont_id))
		{
			$data['message'] = 'Subcontractors_id Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$delSubContractor = SubContractorsCosts::where('sc_id',$subcontractors_id)->delete();

		if($delSubContractor)
		{
			$data['message'] = 'Sub Contractor deleted successfully!';
			$data['status'] = true;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to view subcontractor 
	*/
	public function viewSubCosts($subcontractors_id)
	{
		$checkSubCont_id = $this->checkSubCont_id($subcontractors_id);
		if(empty($checkSubCont_id))
		{
			$data['message'] = 'Subcontractors_id Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$viewSubContractor = SubContractorsCosts::where('sc_id',$subcontractors_id)->first();
		$getCompany = CompanyClaims::where('claim_id',$viewSubContractor->claim_id)->first();

		if($viewSubContractor)
		{
			$data['message'] = 'Sub Contractor retrived successfully!';
			$data['status'] = true;
			$data['SubContractor_data'] = $viewSubContractor;
			$data['company_data'] = $getCompany;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to view subcontractor 
	*/
	public function ListSubCosts($claim_id)
	{
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}


		$viewSubContractor = SubContractorsCosts::where('claim_id',$claim_id)->get();
		$getCompany = CompanyClaims::where('claim_id',$claim_id)->first();
// print_r($viewSubContractor);die;
		if(!$viewSubContractor->isEmpty())
		{
			$data['message'] = 'Sub Contractors retrived successfully!';
			$data['status'] = true;
			$data['SubContractor_data'] = $viewSubContractor;
			$data['company_data'] = $getCompany;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data; 
	}

	/*
	* Function to add Consumable Costs
	*/
	public function addCosts(Request $request, $claim_id,$expenditure)
	{

		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		//$expenditure = $requestData['expenditure'];
		$total_amount = $requestData['total_amount'];
		$per_attributed = $requestData['per_attributed'];	
		$created_at = date('Y-m-d H:i:s');

		$getData = Costs::where('claim_id',$claim_id)
					->where('expenditure','Like','%'.$expenditure.'%')
					->get();
		
		if(count($getData) == 1)
		{
			$addArr = array(
				'claim_id' =>$claim_id,
				'expenditure' => $expenditure,
				'total_amount' => $total_amount,
				'per_attributed' => $per_attributed,
				'updated_at' =>$created_at
			);

			$addSubData = Costs::where('claim_id',$claim_id)
							->where('expenditure','LIKE','%'.$expenditure.'%')
							->update($addArr);
		}
		else{			

			$addArr = array(
				'claim_id' =>$claim_id,
				'expenditure' => $expenditure,
				'total_amount' => $total_amount,
				'per_attributed' => $per_attributed,
				'created_at' =>$created_at
			);
			$addSubData = Costs::insertGetId($addArr);
		}
			
		$getData = Costs::where('claim_id',$claim_id)
						->where('expenditure','Like','%'.$expenditure.'%')
						->first();

		if($getData)
		{
			if($expenditure =='reimbursed'){
				$data['expenses']  = 'true';
			}elseif($expenditure =='software'){
				$data['softwareCosts']  = 'true';
			}elseif($expenditure =='raw-material' || $expenditure =='utilities'){
				$data['consumableCosts']  = 'true';
			}
			
			$this->updateClaimProgressPrivate($data,$claim_id);
			
			$data['message'] = 'Consumable Costs updated successfully!';
			$data['status'] = true;
			$data['subcontractors_data'] = $getData;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}

	/*
	* Function to get List of costs
	*/
	public function listCosts($claim_id,$expenditure)
	{	
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$getList = Costs::where('claim_id',$claim_id)
					->where('expenditure','Like','%'.$expenditure.'%')
					->first();

		if($getList)
		{
			$data['message'] = 'List retrived successfully!';
			$data['status'] = true;
			$data['cost_data'] = $getList;
		}
		else{
			$data['message'] = 'Something went wrong';
			$data['status'] = false;
		}

		return $data;
	}
	
	
		/*
	* Function to add Commercial Goals
	*/
	public function addCommercialGoals(Request $request, $claim_id)
	{

		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{

			
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$created_at = date('Y-m-d H:i:s');

		$getData = DB::table('commercial_goals')->where('claim_id',$claim_id)
					->get();
		
		if(count($getData) == 1)
		{
			$addArr = array(
				'claim_id' =>$claim_id,
				'markets' => $requestData['markets'],
				'competition' => $requestData['competition'],
				'scale' => $requestData['scale'],
				'processess' => $requestData['processess'],
				'products' => $requestData['products'],
				'finance' => $requestData['finance'],
			);

			$addSubData = DB::table('commercial_goals')->where('claim_id',$claim_id)
							->update($addArr);
							
			$addSubData	=	1;
		}
		else{			

			$addArr = array(
				'claim_id' =>$claim_id,
				'markets' => $requestData['markets'],
				'competition' => $requestData['competition'],
				'scale' => $requestData['scale'],
				'processess' => $requestData['processess'],
				'products' => $requestData['products'],
				'finance' => $requestData['finance'],
				'created_at' =>$created_at
			);
			$addSubData = DB::table('commercial_goals')->insertGetId($addArr);
		}

		if($addSubData)
		{
			$data['commercialGoals']  = 'true';
			$this->updateClaimProgressPrivate($data,$claim_id);
			
			$data['message'] = 'Commercial data added successfully!';
			$data['status'] = true;
			$data['subcontractors_data'] = $getData;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}
	
	
	
		/*
	* Function to add aims
	*/
	public function addAims(Request $request, $claim_id)
	{

		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$created_at = date('Y-m-d H:i:s');

		$getData = DB::table('aims')->where('claim_id',$claim_id)
					->get();
		
		if(count($getData) == 1)
		{
			$addArr = array(
				'claim_id' =>$claim_id,
				'blueSkyThinking' => $requestData['blueSkyThinking'],
				'practical' => $requestData['practical'],
				'difficulty' => $requestData['difficulty'],
				'newResearch' => $requestData['newResearch'],
			);

			$addSubData = DB::table('aims')->where('claim_id',$claim_id)
							->update($addArr);
							
			$addSubData	=	1;
		}
		else{			

			$addArr = array(
				'claim_id' =>$claim_id,
				'blueSkyThinking' => $requestData['blueSkyThinking'],
				'practical' => $requestData['practical'],
				'difficulty' => $requestData['difficulty'],
				'newResearch' => $requestData['newResearch'],
				'created_at' =>$created_at
			);
			$addSubData = DB::table('aims')->insertGetId($addArr);
		}

		if($addSubData)
		{
			$data['aims']  = 'true';
			$this->updateClaimProgressPrivate($data,$claim_id);
			
			$data['message'] = 'Aims data added successfully!';
			$data['status'] = true;
			$data['subcontractors_data'] = $getData;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}
		
		
	/*
	* Function to add Difficulties
	*/
	public function addDifficulties(Request $request, $claim_id)
	{

		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$created_at = date('Y-m-d H:i:s');

		$getData = DB::table('difficulties')->where('claim_id',$claim_id)
					->get();
		
		if(count($getData) == 1)
		{
			$addArr = array(
				'claim_id' =>$claim_id,
				'isAccessible' => $requestData['isAccessible'],
				'isProtected' => $requestData['isProtected'],
				'conflict' => $requestData['conflict'],
				'difficult' => $requestData['difficult'],
			);

			$addSubData = DB::table('difficulties')->where('claim_id',$claim_id)
							->update($addArr);
							
			$addSubData	=	1;
		}
		else{			

			$addArr = array(
				'claim_id' =>$claim_id,
				'isAccessible' => $requestData['isAccessible'],
				'isProtected' => $requestData['isProtected'],
				'conflict' => $requestData['conflict'],
				'difficult' => $requestData['difficult'],
				'created_at' =>$created_at
			);
			$addSubData = DB::table('difficulties')->insertGetId($addArr);
		}

		if($addSubData)
		{
			
			$data['difficulties']  = 'true';
			$this->updateClaimProgressPrivate($data,$claim_id);
			
			$data['message'] = 'Difficulties are added successfully!';
			$data['status'] = true;
			$data['subcontractors_data'] = $getData;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}
	
	
	/*
	* Function to Technical Challenge
	*/
	public function addTechnicalChallenge(Request $request, $claim_id)
	{

		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$created_at = date('Y-m-d H:i:s');

		$getData = DB::table('technical_challenge')->where('claim_id',$claim_id)
					->get();
		
		if(count($getData) == 1)
		{
			$addArr = array(
				'claim_id' =>$claim_id,
				'software' => $requestData['software'],
				'manufacture' => $requestData['manufacture'],
				'material' => $requestData['material'],
			);

			$addSubData = DB::table('technical_challenge')->where('claim_id',$claim_id)
							->update($addArr);
							
			$addSubData	=	1;
		}
		else{			

			$addArr = array(
				'claim_id' =>$claim_id,
				'software' => $requestData['software'],
				'manufacture' => $requestData['manufacture'],
				'material' => $requestData['material'],
				'created_at' =>$created_at
			);
			$addSubData = DB::table('technical_challenge')->insertGetId($addArr);
		}

		if($addSubData)
		{
			$data['technicalChallenges']  = 'true';
			$this->updateClaimProgressPrivate($data,$claim_id);
		
			$data['message'] = 'Technical challenge  added successfully!';
			$data['status'] = true;
			$data['subcontractors_data'] = $getData;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}
	
	
		/*
	* Function to add declaration
	*/
	public function addDeclaration(Request $request, $claim_id)
	{

		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$created_at = date('Y-m-d H:i:s');

		$getData = DB::table('declaration')->where('claim_id',$claim_id)
					->get();
		
		if(count($getData) == 1)
		{
			$addArr = array(
				'claim_id' =>$claim_id,
				'signatureSrc' => $requestData['signatureSrc'],
				'signedBy' => $requestData['signedBy'],
				'declaration' => $requestData['declaration'],
				'businessTerms' => $requestData['businessTerms'],
			);

			$addSubData = DB::table('declaration')->where('claim_id',$claim_id)
							->update($addArr);
							
			$addSubData	=	1;
		}
		else{			

			$addArr = array(
				'claim_id' =>$claim_id,
				'signatureSrc' => $requestData['signatureSrc'],
				'signedBy' => $requestData['signedBy'],
				'declaration' => $requestData['declaration'],
				'businessTerms' => $requestData['businessTerms'],
				'created_at' =>$created_at
			);
			$addSubData = DB::table('declaration')->insertGetId($addArr);
		}

		if($addSubData)
		{
			$data['declaration']  = 'true';
			$this->updateClaimProgressPrivate($data,$claim_id);
		
			$data['message'] = 'Data  added successfully!';
			$data['status'] = true;
			$data['subcontractors_data'] = $getData;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}
	
	/*
	* Function to add NOn Technical Area
	*/
	public function addNonTechnicalArea(Request $request, $claim_id)
	{

		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$requestData = $request->input();

		$created_at = date('Y-m-d H:i:s');

		$getData = DB::table('non_tech_area')->where('claim_id',$claim_id)
					->get();
		
		if(count($getData) == 1)
		{
			$addArr = array(
				'claim_id' =>$claim_id,
				'contracts' => $requestData['contracts'],
				'devDiaries' => $requestData['devDiaries'],
				'docsResults' => $requestData['docsResults'],
				'invoices' => $requestData['invoices'],
				'projectPlans' => $requestData['projectPlans'],
				'prototypes' => $requestData['prototypes'],
				'relatedFiles' => $requestData['relatedFiles'],
				'relevantEmails' => $requestData['relevantEmails'],
				'sprintPlan' => $requestData['sprintPlan'],
				'timeSheets' => $requestData['timeSheets'],
			);

			$addSubData = DB::table('non_tech_area')->where('claim_id',$claim_id)
							->update($addArr);
							
			$addSubData	=	1;
		}
		else{			

			$addArr = array(
				'claim_id' =>$claim_id,
				'contracts' => $requestData['contracts'],
				'devDiaries' => $requestData['devDiaries'],
				'docsResults' => $requestData['docsResults'],
				'invoices' => $requestData['invoices'],
				'projectPlans' => $requestData['projectPlans'],
				'prototypes' => $requestData['prototypes'],
				'relatedFiles' => $requestData['relatedFiles'],
				'relevantEmails' => $requestData['relevantEmails'],
				'sprintPlan' => $requestData['sprintPlan'],
				'timeSheets' => $requestData['timeSheets'],
				'created_at' =>$created_at
			);
			$addSubData = DB::table('non_tech_area')->insertGetId($addArr);
		}

		if($addSubData)
		{  
			$data['nonTechAreas']  = 'true';
			$this->updateClaimProgressPrivate($data,$claim_id);
			
			$data['message'] = 'Non Technical area  added successfully!';
			$data['status'] = true;
			$data['subcontractors_data'] = $getData;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}

		return $data;
	}
	
		/*
	* Function to get List of CommercialGoals
	*/
	public function listCommercialGoals($claim_id)
	{	
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$getList = DB::table('commercial_goals')->where('claim_id',$claim_id)
					->first();

		if($getList)
		{
			$data['message'] = 'List retrived successfully!';
			$data['status'] = true;
			$data['cost_data'] = $getList;
		}
		else{
			$data['message'] = 'Something went wrong';
			$data['status'] = false;
		}

		return $data;
	}	

	/*
	* Function to get List of listTechnicalClaims
	*/
	public function listTechnicalClaims($claim_id)
	{	
		$checkClaim = $this->claimCheck($claim_id);
		if(empty($checkClaim))
		{
			$data['message'] = 'Claim Not found!';
			$data['status'] = false;

			return $data; die;
		}

		$getList = DB::table('commercial_goals')->where('claim_id',$claim_id)
					->first();

		if($getList)
		{	
			$data['message'] 			=	'List retrived successfully!';
			$data['status'] 			= 	true;
			$data['commercial_goals'] 	= 	$getList;
			$data['aims'] 				=  	DB::table('aims')->where('claim_id',$claim_id)->first();
			$data['difficulties'] 		=  	DB::table('difficulties')->where('claim_id',$claim_id)->first();
			$data['technical_challenge']=  	DB::table('technical_challenge')->where('claim_id',$claim_id)->first();
			$data['non_tech_area']		=  	DB::table('non_tech_area')->where('claim_id',$claim_id)->first();
			$data['declaration']		=  	DB::table('declaration')->where('claim_id',$claim_id)->first();
		}
		else{
			$data['message'] = 'Something went wrong';
			$data['status'] = false;
		}

		return $data;
	}
	
	/*
	* Function to search companies
	*/

	public function searchCompany(Request $request,$filter)
	{
		$ch = curl_init();
		
		$headr = array();
		$headr[] = 'Content-length: 0';
		$headr[] = 'Content-type: application/json';
		$headr[] = 'Authorization: ppr_LDhZFRd3xEbrMmMh9aE75ZGDrzy_EIfIn_Fh';
		
		 curl_setopt($ch, CURLOPT_URL, 'https://api.companieshouse.gov.uk/search/companies/?q='.str_replace(' ','',$filter).'&items_per_page=20');
		 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		 curl_setopt($ch, CURLOPT_HTTPHEADER,$headr);
		 $response = curl_exec ($ch);
		 $err = curl_error($ch);  //if you need
		 curl_close ($ch);
		 return $response;
	}

	/*
	* Function to check if company name exits or not
	*/

	public function checkCompany(Request $request,$company_name)
	{
		$companyCheck = DB::table('client_company')->where('company_name','Like','%'.$company_name.'%')->first();

		if(!empty($companyCheck))
		{
			$data['message'] = 'Company name already Exists!';
			$data['status'] = false;
			$data['company_data'] =  $companyCheck;
		}
		else{
			$data['message'] = 'Company name does not exists!';
			$data['status'] = true;
		}

		return $data;
	}
	
	public function getSettings(){
		$url = url('/images/');
		$companyCheck = DB::table('settings')->select(DB::raw('*,CONCAT("'.$url.'/",logo) as logo,CONCAT("'.$url.'/",favicon) as favicon,CONCAT("'.$url.'/",powered_by) as powered_by'))->first();

		if(!empty($companyCheck))
		{
			unset($companyCheck->password);
			$companyCheck->epw_cost_new	=	$companyCheck->epw_cost*100;
			// echo $companyCheck->epw_cost;die;
			$data['message'] = 'Settings retrived !';
			$data['status'] = true;
			$data['data'] =  $companyCheck;
		}
		else{
			$data['message'] = 'Something went wrong!';
			$data['status'] = false;
		}
		return $data;
	}	
	
	public function updateSettings(Request $request){
		$data			=	json_decode($request->input('data'),true);
		$savedData 		= 	DB::table('settings')->first();
		$data['epw_cost']	=	$data['epw_cost']/100;
		// dd($data['epw_cost']);die;
		if ($request->hasFile('logo'))
		{
			$data['logo'] = $this->uploadFile($savedData,$request,'logo');
		}	
		if ($request->hasFile('favicon'))
		{
			$data['favicon'] = $this->uploadFile($savedData,$request,'favicon');
		}	
		if ($request->hasFile('powered_by'))
		{
			$data['powered_by'] = $this->uploadFile($savedData,$request,'powered_by');
		}
		$res	= DB::table('settings')->update($data);
		
		if(!empty($res))
		{
			$result['message'] 	= 'Settings updated  !';
			$result['status'] 	= true;

		}
		else{
			$result['message'] = 'Something went wrong!';
			$result['status'] = false;
		}
		return $result;
	}
	
	function uploadFile($savedData,$request,$file_name){
		$picture	=	'';
		$file      = $request->file($file_name);
		$filename  = $file->getClientOriginalName();
		$extension = $file->getClientOriginalExtension();
		$picture   = $file_name.sha1(time()).'.'.$extension;
		if($file->move(public_path('images'), $picture)){
			if( $savedData->{$file_name} !='' && file_exists(public_path('images/'.$savedData->{$file_name}))){
				unlink(public_path('images/'.$savedData->{$file_name}));
			}
		}
		return $picture;
		
	}
	
	
	public function updateProfile(Request $request,$userID){
		$updated_at 	= 	date('Y-m-d H:i:s');    
		$Userdata = array(
			'first_name' =>	$request['first_name'],
			'updated_at' =>	$updated_at,
		);
		
		if(!empty($request['password']))
		{
			$Userdata['password']	=	Hash::make($request['password']);
		}
		
      	$UserUpdate		= 	DB::table('users')->where('id',$userID)->update($Userdata); // update user
		
		if(!empty($UserUpdate))
		{
			$result['message'] 	= 'Profile updated  !';
			$result['status'] 	= true;

		}
		else{
			$result['message'] = 'Something went wrong!';
			$result['status'] = false;
		}
		return $result;
	}
	
}
