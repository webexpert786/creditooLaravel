<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class RolesPermission extends Model
{
    protected $table = 'roles_permission';

    protected $primaryKey = 'id';

    protected $fillable = [
        'id', 'role_id','permission_key','permission_value'
    ];
}
