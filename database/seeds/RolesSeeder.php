<?php

use Illuminate\Database\Seeder;

class RolesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
         DB::table('roles')->insert([
     	[
            'role_name' => 'Admin',
            'created_at'=> date('Y-m-d H:i:s'),
        ],
        [
            'role_name' => 'Sub-Admin',
            'created_at'=> date('Y-m-d H:i:s'),
        ],
        [
            'role_name' => 'Client',
            'created_at'=> date('Y-m-d H:i:s'),
        ],
        [
            'role_name' => 'Manager',
            'created_at'=> date('Y-m-d H:i:s'),
        ]
    	]);
    }
}
