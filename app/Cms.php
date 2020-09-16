<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Cms extends Model
{
    protected $table = 'cms';

    protected $primaryKey = 'id';

    protected $fillable = [
        'cms_title', 'cms_slug', 'cms_meta_title','cms_meta_description','cms_detail','cms_status'
    ];
}
