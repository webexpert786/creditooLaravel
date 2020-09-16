<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCompanyInvitesTables extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('company_invites', function (Blueprint $table) {
            $table->bigIncrements('invite_id');
            $table->string('invite_token');
            $table->Integer('claim_id');
            $table->string('invite_name');
            $table->string('invite_email');
            $table->mediumText('invite_roles');
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
        Schema::dropIfExists('company_invites');
    }
}
