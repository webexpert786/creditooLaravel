<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call(UserSeeder::class);         // User table 
        $this->call(UserRolesSeeder::class);    // User Role Table
        $this->call(RolesSeeder::class);        // Roles Table
    }
}
