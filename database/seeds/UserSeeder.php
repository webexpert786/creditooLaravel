<?php

use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([[
            'first_name' => 'Admin',
            'parent_id'=>0,
            'email' => 'admin@yopmil.com',
            'password' => Hash::make('password@786'),
            'api_token' => sha1(rand().time()),
            'created_at'=> date('Y-m-d H:i:s'),
        ],[
            'first_name' => 'Sub Admin',
            'parent_id'=>0,
            'email' => 'subadmin@yopmail.com',
            'password' => Hash::make('password@786'),
            'api_token' => sha1(rand().time()),
            'created_at'=> date('Y-m-d H:i:s'),
        ],
        [
            'first_name' => 'Client',
            'parent_id'=>1,
            'email' => 'client@yopmail.com',
            'password' => Hash::make('password@786'),
            'api_token' => sha1(rand().time()),
            'created_at'=> date('Y-m-d H:i:s'),
        ]
    ]);
    }
}
