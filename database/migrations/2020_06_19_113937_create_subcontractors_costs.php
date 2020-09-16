<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSubcontractorsCosts extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('subcontractors_costs', function (Blueprint $table) {
            $table->bigIncrements('sc_id');
            $table->Integer('claim_id');
            $table->Integer('total_amount');
            $table->Integer('per_attributed');
            $table->Text('description');
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
        Schema::dropIfExists('subcontractors_costs');
    }
}
