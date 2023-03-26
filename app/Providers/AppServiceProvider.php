<?php

namespace App\Providers;

use App\Models\Paciente;
use Illuminate\Support\ServiceProvider;
use App\Repositories\PacienteRepositoryEloquent;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind('App\Repositories\PacienteRepositoryInterface', 'PacienteRepositoryEloquent');
        $this->app->bind('App\Repositories\PacienteRepositoryInterface', function(){
            return new PacienteRepositoryEloquent(new Paciente());
        });
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
