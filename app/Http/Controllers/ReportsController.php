<?php

namespace App;
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use App\Roles; 
use App\RolesPermission;
use Illuminate\Support\Facades\DB;

class ReportsController extends Controller
{
    /*
	* Function to get list of roles
	*/
    public function getReports(Request $request)
    {
        $data 	= $request->all() ;
        $page 	= $data['page'];
        $limit 	= $data['limit']??5 ;

		
		$RolesGet		= DB::table('reports');
		if(!empty($data['filter'])){
			$claims 	=	 DB::table('claims')->where('company_id',$data['filter'])->pluck('id')->toArray();
			$RolesGet	=	$RolesGet->WhereIn('claim_id',$claims);
		}
	
		if(!empty($data['created_by'])){
			$user 		= DB::select( DB::raw("select * from (select *,CONCAT(first_name,' ',last_name) as name from users ) as tab where tab.name like '%".$data['created_by']."' ") );
			if(!empty($user)){
				$clients 	=	 DB::table('client_company')->where('added_by',$user[0]->id)->pluck('company_id')->toArray();
				if(!empty($clients)){
					$claims 		=	 DB::table('claims')->WhereIn('company_id',$clients)->pluck('id')->toArray();
					if(!empty($claims)){
						$RolesGet		=	$RolesGet->WhereIn('claim_id',$claims);
					}
				}
			}
		}
		
		if($data['status'] !=''){
			$RolesGet		=	$RolesGet->where('status',$data['status']);
		}
		
		if(!empty($data['start_date']) && !empty($data['end_date'])){
			// $RolesGet		=	$RolesGet->whereBetween('created_at', [$data['start_date'], $data['end_date']]);
			$RolesGet		=	$RolesGet->whereRaw(DB::raw("DATE(created_at) >= '".$data['start_date']."' AND  DATE(created_at) <= '".$data['end_date']."' "));
		}

		$RolesGet		=	$RolesGet->orderBy('id','DESC');

		$totalRoles			= count($RolesGet->get());
        if(!empty($limit)){
        	$RolesGet		= $RolesGet->limit($limit)->offset(($page) * $limit)->get();
        }
		else{
			$RolesGet		= $RolesGet->get();
		}
		

	      if(count($RolesGet) > 0)
	      {
			foreach($RolesGet as $list){
				$getClaimData			=	DB::table('claims')->Where('id',$list->claim_id)->first();
				$getClientData			=	DB::table('client_company')->Where('company_id',$getClaimData->company_id)->first();
				$getUserData			=	DB::table('users')->Where('id',$getClientData->added_by)->first();
				$company_claims			=	DB::table('company_claims')->Where('claim_id',$list->claim_id)->first();
				 
				$list->claim_period		=	date("d/m/Y",strtotime($company_claims->year_end_date.' -1 year'))." - ".date("d/m/Y",strtotime($company_claims->year_end_date));
				$list->client_name		=	$getClientData->company_name;
				$list->user_name		=	$getUserData->first_name.' '.$getUserData->last_name;
				$list->created_at		=	date("d/m/Y",strtotime($list->created_at));
				$newArray[]				=	$list;
			}
		
	      	$data['message'] 	= 'List has been retrived';
	      	$data['status']		= true;
	      	$data['data']		= $newArray;
	      	$data['count']		= $totalRoles;
	      }else {
	      	$data['message'] 	= 'No list found';
	      	$data['status']		=  false;
	      	$data['data']		=  '';
	      	$data['count']		=  0;
	      }
	      return $data;
    }

    /*
    * Function to add Reports
    */
    public function add(Request $request)
    {
    	$requestData 				= 	$request->all();
		if(!empty($requestData)){
			
			$checkReport			=	DB::table('reports')->where('claim_id',$requestData['claim_id'])->first();
			if(!empty($checkReport)){
				DB::table('reports')->where('claim_id',$requestData['claim_id'])->delete();
			}
			
			$requestData['created_at'] 	= 	date('Y-m-d h:i:s');
			$res 						= 	DB::table('reports')->insertGetId($requestData);
			if($res){
				$data['message'] 	= 'Claim has been finalised';
				$data['status'] 	= true;
			}
			else{
				$data['message'] 	= 'Something went wrong!';
				$data['status'] 	= false;
			}
		}else{
				$data['message'] 	= 'Empty Data';
				$data['status'] 	= false;
		}

    	return $data;
    }


    /*
    * Function to update Reports
    */
    public function updateReport(Request $request,$id)
    {
    	$requestData 				= 	$request->all();
		if(!empty($requestData)){		

			$res 						= 	DB::table('reports')->where('id',$id)->update($requestData);
			if($res){
				$data['message'] 	= 'Report has been updated';
				$data['status'] 	= true;
			}
			else{
				$data['message'] 	= 'Something went wrong!';
				$data['status'] 	= false;
			}
		}else{
				$data['message'] 	= 'Empty Data';
				$data['status'] 	= false;
		}

    	return $data;
    }
   
    /*
    * Function to delete Report
    */

    public function deleteReport(Request $request,$id)
    {	
		$del	 =	 DB::table('reports')->where('id',$id)->delete();

    	if($del)
    	{
    		$data['message'] = 'Report deleted successfully!';
    		$data['status'] = true;
    	}
    	else{
    		$data['message'] = 'Something went wrong!';
    		$data['status'] = false;
    	}

    	return $data;
    }
	
	
public function downloadAsCsv(Request $request)
    {
        $data 	= $request->all() ;
        $page 	= $data['page'];
        $limit 	= $data['limit']??5 ;

		
		$RolesGet		= DB::table('reports');
		if(!empty($data['filter'])){
			$claims 	=	 DB::table('claims')->where('company_id',$data['filter'])->pluck('id')->toArray();
			$RolesGet	=	$RolesGet->WhereIn('claim_id',$claims);
		}
	
		if(!empty($data['created_by'])){
			$user 		= DB::select( DB::raw("select * from (select *,CONCAT(first_name,' ',last_name) as name from users ) as tab where tab.name like '%".$data['created_by']."' ") );
			if(!empty($user)){
				$clients 	=	 DB::table('client_company')->where('added_by',$user[0]->id)->pluck('company_id')->toArray();
				if(!empty($clients)){
					$claims 		=	 DB::table('claims')->WhereIn('company_id',$clients)->pluck('id')->toArray();
					if(!empty($claims)){
						$RolesGet		=	$RolesGet->WhereIn('claim_id',$claims);
					}
				}
			}
		}
		
		if($data['status'] !=''){
			$RolesGet		=	$RolesGet->where('status',$data['status']);
		}
		
		if(!empty($data['start_date']) && !empty($data['end_date'])){
			// $RolesGet		=	$RolesGet->whereBetween('created_at', [$data['start_date'], $data['end_date']]);
			$RolesGet		=	$RolesGet->whereRaw(DB::raw("DATE(created_at) >= '".$data['start_date']."' AND  DATE(created_at) <= '".$data['end_date']."' "));
		}				
		
        if(!empty($limit)){
        	$RolesGet		= $RolesGet->limit($limit)->offset(($page) * $limit)->get();
        }
		else{
			$RolesGet		= $RolesGet->get();
		}
	

	      if(count($RolesGet) > 0)
	      {
			$i=1;
			$settings 	= 	DB::table('settings')->first();
			foreach($RolesGet as $list){
				$new_list				=	$list;
				$getClaimData			=	DB::table('claims')->Where('id',$list->claim_id)->first();
				$getClientData			=	DB::table('client_company')->Where('company_id',$getClaimData->company_id)->first();
				$getUserData			=	DB::table('users')->Where('id',$getClientData->added_by)->first();
				$company_claims			=	DB::table('company_claims')->Where('claim_id',$list->claim_id)->first();
				$claim_id				=	$list->claim_id;
				// dd($getClientData);die;
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

	
										

				$new_list->Sr					=	$i++;
				$new_list->client				=	$getClientData->company_name;
				$new_list->incorporated_date	=	$getClientData->incorporated_date;
				$new_list->incorporated_date	=	date('d/m/Y', strtotime($new_list->incorporated_date));
				$new_list->profit_or_loss		=	$company_claims->profit_loss;
				$new_list->report_number		=	base64_encode($list->id);
				$new_list->report_date			=	$list->created_at;
				$new_list->reported_by			=	$getUserData->first_name.' '.$getUserData->last_name;
				
				if($list->status == 1){
					$new_list->report_status	=	"Active";
				}else{
					$new_list->report_status	=	"In-Active";
				}
				
				$new_list->claim_period			=	date("d/m/Y",strtotime($company_claims->year_end_date.' -1 year'))." - ".date('d/m/Y', strtotime($company_claims->year_end_date));
				$new_list->claim_status			=	$getClaimData->status;
				$new_list->is_finalise			=	'Yes';
				$new_list->year_end_date		=	$company_claims->year_end_date;
				$new_list->year_end_date	=	date('d/m/Y', strtotime($new_list->year_end_date));
				$new_list->invites			=	count(DB::table('company_invites')->where('claim_id',$claim_id)->get());
				
				if(count($projectGet)>=1){
					$new_list->projects = 'Yes('.count($projectGet).')';
				}else{
					$new_list->projects = 'No('.count($projectGet).')';
				}
				
				if(count($staffCost)!=0 && count($EPWCost)!=0 && count($SubContractorsCosts)!=0 && count($costs)!=0){
					$new_list->cost 		= 	'Yes';
				}else{
					$new_list->cost		= 	'No';
				}	
				
				if(count($commercial_goals)!=0 && count($aims)!=0 && count($difficulties)!=0 && count($technical_challenge)!=0&& count($non_tech_area)!=0){
					$new_list->technical 	= 	'Yes';
				}else{
					$new_list->technical 	= 	'No';
				}


				if(count($declaration)!=0){
					$new_list->declaration	= 	'Yes';
				}else{
					$new_list->declaration	= 	'No';
				}
				
				$new_list->sme_spend		= number_format(array_sum($staffCostTotal)+array_sum($EPWCostTotal)+array_sum($SubContractorsCostsTotal)+array_sum($costsTotal),2);
				
				$new_list->paid				=	$getClaimData->paid_status;
				
				unset($new_list->id);
				unset($new_list->claim_id);
				unset($new_list->status);
				unset($new_list->created_at);
				
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
	
		
		
	
}
