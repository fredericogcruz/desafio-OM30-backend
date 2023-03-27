<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Database\Eloquent\Model;
use App\Repositories\PacienteRepositoryInterface;

class PacienteController extends Controller
{
    protected $repo;

    public function __construct(PacienteRepositoryInterface $repo)
    {
        $this->repo = $repo;
    }

    public function __invoke()
    {
    }

    public function store(Request $request)
    {
        $this->repo->store([
                'nome' => $request->nome,
                'idade' => $request->idade,
                'sexo'  => $request->sexo,
                'peso'  => $request->peso,
                'cpf'  => $request->cpf,
                'endereco_id'  => $request->endereco_id,
        ]);
    }

    public function getList()
    {
        return $this->repo->getList();
    }

    public function get($id)
    {
        return $this->repo->get($id);
    }

    public function update(Request $request, $id)
    {
        return $this->repo->update([
            'nome' => $request->nome,
            'idade' => $request->idade,
            'sexo'  => $request->sexo,
            'peso'  => $request->peso,
            'cpf'  => $request->cpf,
            'endereco_id'  => $request->endereco_id,
        ], $id);
    }

    public function destroy($id)
    {
        return $this->repo->get($id)->destroy($id);
    }
}
