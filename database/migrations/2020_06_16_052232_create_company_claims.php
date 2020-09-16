<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCompanyClaims extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('company_claims', function (Blueprint $table) {
            $table->bigIncrements('cid');
            $table->Integer('claim_id');
            $table->string('number_of_directors');
            $table->string('number_of_staff');
            $table->string('year_end_date');
            $table->string('profit_loss');
            $table->string('turnover');
            $table->string('gross_balance_sheet');
            $table->string('grants');
            $table->string('property_ownership');
            $table->string('part_of_group');
            $table->string('name_of_group');
            $table->string('percentage_own');
            $table->text('about_us');
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
        Schema::dropIfExists('company_claims');
    }
}
