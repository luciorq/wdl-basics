version development

workflow print_output {
  call print_file
}

task print_file {
  input {
    String file_name
  }
  command {
    pwd;
    cat '${file_name}';
  }
  output {
    # Write output to standard out
    File cat_output = stdout()
  }
}