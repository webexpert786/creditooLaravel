<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateConsumableCostsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('consumable_costs', function (Blueprint $table) {
            $table->bigIncrements('cc_id');
            $table->Integer('claim_id');
            $table->Integer('rm_total_amount');
            $table->Integer('rm_per_attributed');
            $table->Integer('utl_total_amount');
            $table->Integer('utl_per_attributed');
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
        Schema::dropIfExists('consumable_costs');
    }
}
