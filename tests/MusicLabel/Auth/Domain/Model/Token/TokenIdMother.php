<?php

namespace Masfernandez\Tests\MusicLabel\Auth\Domain\Model\Token;

use Masfernandez\MusicLabel\Shared\Domain\Model\Token\TokenId;

class TokenIdMother
{
    public static function create(?int $id = PHP_INT_MAX): TokenId
    {
        // id null will be auto-generated by DB
        return new TokenId($id);
    }
}