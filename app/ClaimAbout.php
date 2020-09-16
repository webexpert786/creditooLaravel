<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ClaimAbout extends Model
{
    protected $table = 'company_about';

    protected $primaryKey = 'about_id';

    protected $fillable = [
        'about_id', 'claim_id','about'
    ];
}
