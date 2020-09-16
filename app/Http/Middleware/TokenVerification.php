<?php

namespace App\Http\Middleware;
use Illuminate\Support\Facades\DB;
use Closure;
  use JWTAuth;
class TokenVerification
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    { 	
	
		if (!empty($request->header('Authorization'))) {
			try {
					$user = JWTAuth::parseToken()->authenticate();
			}catch (Exception $e) {
					if ($e instanceof \Tymon\JWTAuth\Exceptions\TokenInvalidException){
						return response(['status'=>false,'message' => 'Token is Invalid'],401);
					}else if ($e instanceof \Tymon\JWTAuth\Exceptions\TokenExpiredException){
						return response(['status'=>false,'message' => 'Token is Expired'],401);
					}else{
						return response(['status'=>false,'message' => 'Authorization Token does not found'],401);
					}
			}
				return $next($request);
		}else{
			return response(['status'=>false,'message' => 'Token is Invalid'],401);
		}
	}
}
