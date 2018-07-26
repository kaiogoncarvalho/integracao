<?php
/**
 *
 * @author Kaio Gonçalves Carvalho <kaio.carvalho@pravaler.com.br>
 * @since 26/07/2018
 *
 */

require_once 'Classes/File.php';

$pattern = $argv[1];
$replacement = $argv[2];
$filename = $argv[3];

$file = new File;

$fileData = $file->getFile($filename);

$file->setFile( preg_replace($pattern, $replacement, $fileData) );