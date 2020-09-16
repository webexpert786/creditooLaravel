<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Invites extends Model
{
    protected $table = 'company_invites';

    protected $primaryKey = 'invite_id';

    protected $fillable = [
        'invite_id', 'invite_token', 'claim_id','invite_name','invite_email','invite_roles'
    ];
}
