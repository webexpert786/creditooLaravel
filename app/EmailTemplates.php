<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmailTemplates extends Model
{
    protected $table = 'email_template';

    protected $primaryKey = 'email_id';

    protected $fillable = [
        'email_id', 'title','subject','body'
    ];
}
