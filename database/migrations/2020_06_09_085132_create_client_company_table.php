<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateClientCompanyTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('client_company', function (Blueprint $table) {
            $table->bigIncrements('company_id');
            $table->bigInteger('added_by');
            $table->string('company_name');
            $table->string('email')->unique();
            $table->string('phone')->nullable();
            $table->string('company_reg');
            $table->string('directory_name');
            $table->string('incorporated_date');           
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations./8
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('client_company');
    }
}
