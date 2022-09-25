<?php

declare(strict_types=1);

namespace Masfernandez\MusicLabel\Infrastructure\Api\Type\Shared;

use Doctrine\DBAL\Platforms\AbstractPlatform;

abstract class DoctrineFloatType extends DoctrineType
{
    public function getSQLDeclaration(array $column, AbstractPlatform $platform): string
    {
        return $platform->getFloatDeclarationSQL($column);
    }
}