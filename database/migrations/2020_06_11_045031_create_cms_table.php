<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCmsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cms', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->Integer('added_by');
            $table->string('cms_title');
            $table->string('cms_slug')->unique();
            $table->string('cms_meta_title');
            $table->mediumText('cms_meta_keyword');
            $table->mediumText('cms_meta_description');
            $table->text('cms_detail');
            $table->Integer('cms_status')->comment('0:disable,1:enable');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('cms');
    }
}
