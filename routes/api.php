<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\PacienteController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::get('/pacientes', [PacienteController::class, 'getList'])->middleware('api');
Route::post('/cadastrar-paciente', [PacienteController::class, 'store'])->middleware('api');
Route::post('/editar-paciente/{id}', [PacienteController::class, 'update'])->middleware('api');
Route::delete('/deletar-paciente/{id}', [PacienteController::class, 'destroy'])->middleware('api');

