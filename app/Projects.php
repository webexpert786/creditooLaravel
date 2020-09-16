<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Projects extends Model
{
    protected $table = 'claim_projects';

    protected $primaryKey = 'project_id';

    protected $fillable = [
        'project_id', 'claim_id','project_type','project_status','project_summary'
    ];
}
