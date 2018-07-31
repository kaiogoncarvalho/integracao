<?php
/**
 *
 * @author Kaio Gonçalves Carvalho <kaio.carvalho@pravaler.com.br>
 * @since 26/07/2018
 *
 */

require_once 'Classes/File.php';

$pattern = $argv[1];
$filename = $argv[2];
$group = $argv[3] ?? 0;

$file = new File;

$fileData = $file->getFile($filename);

preg_match($pattern, $fileData, $matches, PREG_OFFSET_CAPTURE, 0);

echo $matches[$group][0];