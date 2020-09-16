<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('register', 'AuthController@register');
Route::post('login', array('middleware' => 'api', 'uses' => 'AuthController@login'));
Route::post('forgot-password','AuthController@forgetPassword');
Route::post('reset-password/{token}','AuthController@resetPassword');


Route::group(['middleware' => 'TokenVerification'], function () {

// Roles routes
Route::get('roles', 'RolesController@getRoles'); 
Route::post('add-role', 'RolesController@addRoles');
Route::put('edit-role/{role_id}', 'RolesController@editRoles');
Route::delete('delete-role/{role_id}', 'RolesController@delRoles');
Route::post('view-role/{role_id}', 'RolesController@viewRoles');

// Users routes
Route::get('users', 'AuthController@getUsers');
Route::post('add-user', 'AuthController@addUser');
Route::get('user/{id}', 'AuthController@viewUser');
Route::post('edit-user/{id}', 'AuthController@editUser');
Route::post('delete-user/{id}', 'AuthController@deleteUser');


// CMS routes
Route::get('list-pages', 'AuthController@allPages');
Route::post('add-page', 'AuthController@addPage');
Route::post('page/{id}', 'AuthController@viewPage');
Route::post('edit-page/{page_id}', 'AuthController@editPage');
Route::post('delete-page/{page_id}', 'AuthController@deletePage');


// Clients routes
Route::get('getCompany/{id}', 'AuthController@getCompany');
Route::get('clients', 'AuthController@getclients');
Route::post('add-client', 'AuthController@addClient');
Route::post('edit-client/{client_id}', 'AuthController@editClient');

// Claim routes
Route::get('update-claim-progress/{id}/{module}', 'AuthController@updateClaimProgress');
Route::get('claims-download-csv/{company_id}', 'AuthController@claimsDownloadAsCsv');
Route::get('getAllClaims/{company_id}', 'AuthController@getAllClaims');
Route::get('getClaims/{claim_id}', 'AuthController@getClaim');
Route::post('add-claim', 'AuthController@addClaim');
Route::post('company-basics/{company_id}', 'AuthController@addCompanyBasics');
Route::post('company-case/{claim_id}', 'AuthController@addCompanyCase');
Route::get('delete-case/{case_id}', 'AuthController@deleteCase');
Route::post('about-company/{claim_id}', 'AuthController@aboutCompany');
Route::post('edit-about-company/{claim_id}', 'AuthController@editaboutCompany');
Route::get('get-about/{claim_id}', 'AuthController@getAbout');

Route::put('update-claim/{claim_id}', 'AuthController@updateClaim');

Route::get('search-company/{filter}', 'AuthController@searchCompany');
Route::get('check-company/{company_name}', 'AuthController@checkCompany');

// Invites routes
Route::get('invite-data/{id}', 'AuthController@getInviteData');	

Route::get('update-invite-token/{id}', 'AuthController@updateInviteTokenStatus');	
Route::post('invite/{claim_id}', 'AuthController@getInvites');	
Route::post('edit-invite/{invite_id}', 'AuthController@editInvite');	
Route::delete('delete-invite/{invite_id}', 'AuthController@deleteInvite');	

// Projects routes
Route::post('add-project/{claim_id}', 'AuthController@addProject');		
Route::delete('delete-project/{project_id}', 'AuthController@deleteProject');	
Route::put('edit-project/{project_id}', 'AuthController@editProject');		

// Staff Costs
Route::get('view-staff-costs/{claim_id}', 'AuthController@ViewStaffCosts');	
Route::post('add-staff-costs/{claim_id}', 'AuthController@addStaffCosts');	
Route::get('view-costs/{cost_id}', 'AuthController@viewCosts');	
Route::post('edit-staff-costs/{cost_id}', 'AuthController@editStaffCosts');		
Route::delete('delete-staff-costs/{cost_id}', 'AuthController@deleteStaffCosts');

// EPW Costs
Route::get('list-epw-costs/{claim_id}', 'AuthController@ListEPWCosts');	
Route::post('add-epw-costs/{claim_id}', 'AuthController@addEPWCosts');	
Route::get('view-epw-cost/{cost_id}', 'AuthController@viewEPWCosts');	
Route::put('edit-epw-costs/{cost_id}', 'AuthController@editEPWCosts');		
Route::delete('delete-epw-costs/{cost_id}', 'AuthController@deleteEPWCosts');		

//Subcontractors COsts routes
Route::post('add-sub-costs/{claim_id}', 'AuthController@addSubCosts');
Route::put('edit-sub-costs/{subcontractors_id}', 'AuthController@editSubCosts');
Route::delete('delete-sub-costs/{subcontractors_id}', 'AuthController@deleteSubCosts');
Route::get('view-sub-costs/{subcontractors_id}', 'AuthController@viewSubCosts');
Route::get('list-sub-costs/{subcontractors_id}', 'AuthController@ListSubCosts');

//Consumable Costs Costs routes
Route::post('add-costs/{claim_id}/{expenditure}', 'AuthController@addCosts');
Route::get('list-costs/{claim_id}/{expenditure}', 'AuthController@listCosts');

//commercial_goals
Route::post('add-commercial-goals/{claim_id}', 'AuthController@addCommercialGoals');
Route::get('list-commercial-goals/{claim_id}', 'AuthController@listCommercialGoals');
Route::get('list-technical-claims/{claim_id}', 'AuthController@listTechnicalClaims');

//Reports
Route::get('download-csv', 'ReportsController@downloadAsCsv');
Route::post('add-report', 'ReportsController@add');
Route::get('list-reports', 'ReportsController@getReports');
Route::put('update-report/{id}', 'ReportsController@updateReport');
Route::delete('delete-report/{id}', 'ReportsController@deleteReport');

//Aims
Route::post('add-aims/{claim_id}', 'AuthController@addAims');

//Difficulties
Route::post('add-difficulties/{claim_id}', 'AuthController@addDifficulties');

//Technical Challenge
Route::post('add-technical-challenge/{claim_id}', 'AuthController@addTechnicalChallenge');

//Technical Challenge
Route::post('add-non-technical-area/{claim_id}', 'AuthController@addNonTechnicalArea');

//declaration 
Route::post('add-declaration/{claim_id}', 'AuthController@addDeclaration');

//Site Settings 

Route::post('update-settings', 'AuthController@updateSettings');

//Update Profile 
Route::put('update-profile/{id}', 'AuthController@updateProfile');


// Email Templates

Route::post('add-email-template', 'EmailController@addEmailTemplate');
Route::post('edit-email-template/{template_id}', 'EmailController@editEmailTemplate');
Route::get('view-email-template/{template_id}', 'EmailController@viewEmailTemplate');
Route::get('list-email-templates', 'EmailController@listEmailTemplate');

});
Route::get('invite-token/{token}', 'AuthController@checkInviteToken');	
Route::get('settings/{get}', 'AuthController@getSettings');
Route::get('page-slug/{slug}', 'AuthController@getPageBySlug');
