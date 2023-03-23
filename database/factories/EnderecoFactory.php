<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class EnderecoFactory extends Factory
{
    public function definition()
    {
        return [
            'cep' => $this->faker->numberBetween(00000000, 99999999),
            'logradouro' => $this->faker->address(),
            'bairro' => $this->faker->regexify('[A-Z]{7}'),
            'cidade' => $this->faker->city(),
            'complemento' => ''
       ];
    }
}
