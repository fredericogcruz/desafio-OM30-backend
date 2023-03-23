<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class PacienteFactory extends Factory
{
    public function definition()
    {
        return [
            'nome' => $this->faker->name,
            'idade' => $this->faker->numberBetween(13, 30),
            'sexo' => $this->faker->regexify('[MF]{1}'),
            'peso' => $this->faker->numberBetween(50, 140),
            'cpf' => $this->faker->numberBetween(00000000000, 99999999999)
       ];
    }
}

