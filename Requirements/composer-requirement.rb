require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class ComposerRequirement < HomebrewPhpRequirement
  COMMAND = 'curl -s http://getcomposer.org/installer | /usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off -d date.timezone=UTC -d apc.enable_cli=Off -- --check'

  def satisfied?
    @result = `#{COMMAND}`
    @result.include? "All settings correct"
  end

  def message
      result_indented = @result.to_s.sub(/^#!.*\n/, '').gsub(/\n^/, "\n    ")
<<-EOS
Composer PHP requirements check has failed. The following verification command:

    #{COMMAND}

failed because of the following reason:

    #{result_indented}
EOS
  end
end
