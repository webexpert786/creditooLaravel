<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEpwCosts extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('epw_costs', function (Blueprint $table) {
            $table->bigIncrements('epw_id');            
            $table->Integer('claim_id');
            $table->string('staff_name');
            $table->Integer('yearly_salary');
            $table->Integer('per_R_D');
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
        Schema::dropIfExists('epw_costs');
    }
}