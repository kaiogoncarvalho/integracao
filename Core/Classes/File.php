<?php
/**
 * <DESCRIÇÃO>
 *
 * PHP VERSION <VERSÂO PHP>
 * @author Kaio Gonçalves Carvalho <kaio.carvalho@pravaler.com.br>
 * @since 26/07/2018
 *
 */

class File
{

    private $file;
    private $filename;

    public function getFile($filename)
    {
        $this->filename=$filename;
        $this->file = file_get_contents($filename);
        return $this->file;
    }

    public function setFile($data)
    {
        file_put_contents($this->filename, $data);
    }

}