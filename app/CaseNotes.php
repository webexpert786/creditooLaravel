<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CaseNotes extends Model
{
    protected $table = 'case_notes';

    protected $primaryKey = 'case_id';

    protected $fillable = [
        'case_id', 'company_id', 'case_notes','created_by'
    ];
}
