<?php

namespace App;
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\EmailTemplates;
use Illuminate\Support\Facades\DB;
class EmailController extends Controller
{
    /*
    * Function to add Email Template
    */

    public function index(Request $request,$filter)
	{
		$ch = curl_init();
		
		$headr = array();
		$headr[] = 'Content-length: 0';
		$headr[] = 'Content-type: application/json';
		$headr[] = 'Authorization: CTYshMpLd-EBYYaDc2KXVVBL8xJGp9Z_j8SwhTiI';
		
		 curl_setopt($ch, CURLOPT_URL, 'https://api.companieshouse.gov.uk/search/companies/?q='.$filter);
		 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		 curl_setopt($ch, CURLOPT_HTTPHEADER,$headr);

		 $response = curl_exec ($ch);
		 $err = curl_error($ch);  //if you need
		 curl_close ($ch);
		 return $response;
	}
    public function addEmailTemplate(Request $request)
    {
    	$requestData = $request->input();

    	$title = $requestData['title'];
    	$subject = $requestData['subject'];
    	$body = $requestData['body'];
    	$created_at = date('d/m/Y H:i:s');

    	$insertArr = array(
    		'title' => $title,
    		'subject' =>$subject,
    		'body' => $body,
    		'created_at' =>$created_at
    	);

    	$addTemplate = EmailTemplates::insertGetId($insertArr);
    	$getTemplate = EmailTemplates::where('email_id',$addTemplate)->first();

    	if($addTemplate)
    	{
    		$data['message'] = 'Template added successfully!';
    		$data['status'] = true;
    		$data['template_data'] = $getTemplate;
    	}
    	else{
    		$data['message'] = 'Something went wrong!';
    		$data['status'] =  false;
    	}

    	return $data;
    }

    /*
    * Check if template id exists
    */
    protected function checkTemplate($template_id)
    {
    	return EmailTemplates::where('email_id',$template_id)->first();
    }

    /*
    * Function to edit Email Template
    */

    public function editEmailTemplate(Request $request,$template_id)
    {	
    	$templateCheck = $this->checkTemplate($template_id);

    	if(empty($templateCheck))
    	{
    		$data['message'] = 'Template not found!';
    		$data['status'] = false;

    		return $data; die;
    	}

    	$requestData = $request->input();

    	$title = $requestData['title'];
    	$subject = $requestData['subject'];
    	$body = $requestData['body'];
    	$updated_at = date('d/m/Y H:i:s');

    	$insertArr = array(
    		'title' => $title,
    		'subject' =>$subject,
    		'body' => $body,
    		'updated_at' =>$updated_at
    	);

    	$addTemplate = EmailTemplates::where('email_id',$template_id)->update($insertArr);
    	
    	$getTemplate = EmailTemplates::where('email_id',$template_id)->first();

    	if($getTemplate)
    	{
    		$data['message'] = 'Template updated successfully!';
    		$data['status'] = true;
    		$data['template_data'] = $getTemplate;
    	}
    	else{
    		$data['message'] = 'Something went wrong!';
    		$data['status'] =  false;
    	}

    	return $data;
    }
    
    /*
    * Function to view Email Template
    */

    public function viewEmailTemplate(Request $request,$template_id)
    {   
        $templateCheck = $this->checkTemplate($template_id);

        if(empty($templateCheck))
        {
            $data['message'] = 'Template not found!';
            $data['status'] = false;

            return $data; die;
        }

        $getTemplate = EmailTemplates::where('email_id',$template_id)->first();

        if($getTemplate)
        {
            $data['message'] = 'Template retireved successfully!';
            $data['status'] = true;
            $data['template_data'] = $getTemplate;
        }
        else{
            $data['message'] = 'Something went wrong!';
            $data['status'] =  false;
        }

        return $data;
    }
    
    /*
    * Function to List Email Template
    */

    public function listEmailTemplate(Request $request)
    {   
		$data 	= $request->all() ;
		$page 	= $data['page'];
        $limit 	= $data['limit']??5 ;
		
		$getTemplate		= DB::table('email_template');
		if(!empty($data['filter'])){
			$filter			=	$data['filter'];
			$getTemplate 	=	 $getTemplate->where('title','LIKE', "%$filter%");
		}
		$count				=	count($getTemplate->get());
		if(!empty($limit)){
        	$getTemplate		= $getTemplate->limit($limit)->offset(($page) * $limit)->get();
        }
		else{
			$getTemplate		= $getTemplate->get();
		}


        if(count($getTemplate)>0)
        {
            $data['message']		= 'Templates retireved successfully!';
            $data['status'] 		= true;
            $data['template_data'] 	= $getTemplate;
            $data['count'] 			= $count;
        }
        else{
            $data['message'] 		= 'No data found!';
            $data['status'] 		=  false;
        }

        return $data;
    }
}
