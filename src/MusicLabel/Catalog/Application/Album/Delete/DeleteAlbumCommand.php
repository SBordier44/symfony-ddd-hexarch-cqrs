<?php

declare(strict_types=1);

namespace Masfernandez\MusicLabel\Catalog\Application\Album\Delete;

use Masfernandez\MusicLabel\Shared\Domain\Model\Album\AlbumId;
use Masfernandez\Shared\Domain\Bus\Command\SyncCommandInterface;

final class DeleteAlbumCommand implements SyncCommandInterface
{
    private AlbumId $id;

    public function __construct(string $id)
    {
        $this->id = new AlbumId($id);
    }

    public function id(): AlbumId
    {
        return $this->id;
    }
}
