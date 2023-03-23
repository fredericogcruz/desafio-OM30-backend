<?php

namespace App\Repositories;

use Illuminate\Database\Eloquent\Model;
use App\Repositories\TaskRepositoryInterface;

class TaskService implements TaskRepositoryInterface
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

    public function update(array $data, $id)
    {
        return $this->repo->update($data, $id);
    }

    public function destroy($id)
    {
        return $this->repo->destroy($id);
    }
}
