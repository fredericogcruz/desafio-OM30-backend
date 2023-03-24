<?php

namespace App\Repositories;

use App\Http\Controllers\Controller;
use Illuminate\Database\Eloquent\Model;
use App\Repositories\TaskRepositoryInterface;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    protected $repo;

    public function __construct(TaskRepositoryInterface $repo)
    {
        $this->repo = $repo;
    }

    public function store(array $data)
    {
        $this->repo->store($data);
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
            'title' => $request->title,
            'description' => $request->description,
        ], $id);
    }

    public function destroy($id)
    {
        return $this->repo->get($id)->destroy();
    }
}
