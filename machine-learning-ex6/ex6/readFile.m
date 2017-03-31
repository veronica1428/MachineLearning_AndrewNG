function file_contents = readFile(filename)
  %READFILE reads a file and returns its entire contents 
  %   file_contents = READFILE(filename) reads a file and returns its entire
  %   contents in file_contents
  %

  % Load File
  fid = fopen(filename);
  filename
  fid
  if fid
      file_contents = textScan(fid, '%c', inf);
      fclose(fid);
  else
      file_contents = '';
      fprintf('Unable to open %s\n', filename);
  end

end

