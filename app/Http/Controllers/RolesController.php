<?php

namespace App;
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Roles;
use App\RolesPermission;
use Illuminate\Support\Facades\DB;

class RolesController extends Controller
{
    /*
	* Function to get list of roles
	*/
    public function getRoles(Request $request)
    {
        $data 	= $request->all() ;
        $page 	= $data['page']??0;
        $limit 	= $data['limit']??5 ;


        $RolesGet		= DB::table('roles');
		if(!empty($data['filter'])){
			$RolesGet	=	$RolesGet->where('role_name','Like',"%".$data['filter']."%"); 
		}

		$totalRoles			= count($RolesGet->get());
        if(!empty($limit)){
        	$RolesGet		= $RolesGet->limit($limit)->offset(($page) * $limit)->get();
        }
		else{
			$RolesGet		= $RolesGet->get();
		}
		
	      if(count($RolesGet) > 0)
	      {
	      	$data['message'] 	= 'Get roles list';
	      	$data['status']		= true;
	      	$data['data']		= $RolesGet;
	      	$data['count']		= $totalRoles;
	      }else {
	      	$data['message'] 	= 'Roles list not found';
	      	$data['status']		=  false;
	      	$data['data']		=  'No role found!';
	      	$data['count']		=  0;
	      }
	      return $data;
    }

    /*
    * Function to add Roles
    */
    public function addRoles(Request $request)
    {
    	$requestData = $request->input();
    	$permissionArr = array();

    	$role_name				= $requestData['role_name'];
    	$role_permissions		= $requestData['role_permissions'];
    	$created_at 			= date('Y-m-d h:i:s');
    	// add roles
    	$roleArr = array(
    		'role_name' => $role_name,
    		'created_at' => $created_at
    	);

    	$addRole = Roles::insertGetId($roleArr);

    	// add Role Permissions with role ID

      	
    	if(count($role_permissions) > 0)
    	{	

    		foreach ($role_permissions as $permissions => $value) {
    			$permissionArr[] = array(
    				//array(
	    			'role_id' => $addRole,
	    			'permission_key' => $permissions,
	    			'permission_value' =>$value,
	    			'created_at' => $created_at
	    		//)
	    		);
    		}

	    	$permissionInsert = RolesPermission::insert($permissionArr);
    	}
    	
    	$getRoles = Roles::where('id',$addRole)->first();
    	$getRolePer = RolesPermission::where('role_id',$addRole)->get();
    	if($addRole)
    	{
    		$data['message'] = 'Role added successfully!';
    		$data['status'] = true;
    		$data['role_data'] = $getRoles;
    		$data['role_permissions'] = $getRolePer;
    	}
    	else{
    		$data['message'] = 'Something went wrong!';
    		$data['status'] = false;
    	}

    	return $data;
    }

    /*
    * Check if role exists or not
    */
    protected function checkRole($role_id)
    {
    	return Roles::where('id',$role_id)->first();
    }

    /*
    * Function to edit Roles
    */
    public function editRoles(Request $request,$role_id)
    {	
    	$roleCheck = $this->checkRole($role_id);
    	if(empty($roleCheck))
    	{
    		$data['message'] = 'Role does not exists';
    		$data['status'] = false;

    		return $data; die;
    	}

    	$requestData = $request->input();
    	$permissionArr = array();

    	$role_name				= $requestData['role_name'];
    	$role_permissions		= $requestData['role_permissions'];
    	$updated_at 			= date('Y-m-d h:i:s');
    	// add roles
    	$roleArr = array(
    		'role_name' => $role_name,
    		'updated_at' => $updated_at
    	);

    	$addRole = Roles::where('id',$role_id)->update($roleArr);

    	// add Role Permissions with role ID

      	
    	if(count($role_permissions) > 0)
    	{	

    		foreach ($role_permissions as $permissions => $value) {
    			$permissionArr = array(
	    			'permission_value' =>$value,
	    			'updated_at' => $updated_at
	    		);

	    		$permissionInsert = RolesPermission::where('role_id',$role_id)
	    						->where('permission_key','Like','%'.$permissions.'%')
	    						->update($permissionArr);
    		}

	    	
    	}
    	
    	$getRoles = Roles::where('id',$role_id)->first();
    	$getRolePer = RolesPermission::where('role_id',$role_id)->get();
    	if($addRole)
    	{
    		$data['message'] = 'Role data updated successfully!';
    		$data['status'] = true;
    		$data['role_data'] = $getRoles;
    		$data['role_permissions'] = $getRolePer;
    	}
    	else{
    		$data['message'] = 'Something went wrong!';
    		$data['status'] = false;
    	}

    	return $data;
    }

    /*
    * Function to view Roles and permission data
    */

    public function viewRoles(Request $request,$role_id)
    {	
    	$roleCheck = $this->checkRole($role_id);
    	if(empty($roleCheck))
    	{
    		$data['message'] = 'Role does not exists';
    		$data['status'] = false;

    		return $data; die;
    	}

    	$getRoles = Roles::where('id',$role_id)->first();
    	$getRolePerm = RolesPermission::where('role_id',$role_id)->get();

    	if($getRoles && $getRolePerm)
    	{
    		$data['message'] = 'Roles information retrived successfully!';
    		$data['status'] = true;
    		$data['role_data'] = $getRoles;
    		$data['role_permissions'] = $getRolePerm;
    	}
    	else{
    		$data['message'] = 'Something went wrong!';
    		$data['status'] = false;
    	}

    	return $data;
    }

    /*
    * Function to delete Roles and permission data
    */

    public function delRoles(Request $request,$role_id)
    {	
    	$roleCheck = $this->checkRole($role_id);
    	if(empty($roleCheck))
    	{
    		$data['message'] = 'Role does not exists';
    		$data['status'] = false;

    		return $data; die;
    	}
		
		
    	$delRoles = Roles::where('id',$role_id)->delete();
    	$delRolesPer = RolesPermission::where('role_id',$role_id)->delete();

    	if($delRoles && $delRolesPer)
    	{
			$getUserWithRole 	= DB::table("user_roles")->where('role_id',$role_id)->pluck('user_id')->toArray();
			$delteUser 			= DB::table("users")->whereIn('id',$getUserWithRole)->update(['status'=>0]);
		
    		$data['message'] = 'Roles information deleted successfully!';
    		$data['status'] = true;
    	}
    	else{
    		$data['message'] = 'Something went wrong!';
    		$data['status'] = false;
    	}

    	return $data;
    }
}
