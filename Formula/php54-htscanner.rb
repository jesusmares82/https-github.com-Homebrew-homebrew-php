require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Htscanner < AbstractPhp54Extension
  init
  homepage 'https://github.com/piannelli/htscanner-enhanced'
  url 'https://github.com/piannelli/htscanner-enhanced/archive/b62ad43105758fe9f513a0730c3bbef0dfd2ee37.tar.gz'
  sha1 'bd1716f6d8d9571855fd73ad52778d57eec7be77'
  version 'b62ad431'
  head 'https://github.com/piannelli/htscanner-enhanced.git'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/htscanner.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      htscanner.config_file = .htaccess
      htscanner.default_ttl = 300
      htscanner.stop_on_error = 0
      htscanner.verbose = 0
    EOS
  end

  def caveats
    super + <<-EOS.undent
      With this small modification in htscanner,
      you can force it to always use the default docroot set in the php.ini configuration.

      Getting back to the previous example,
      assuming you are hosting your vhosts under /home/public_html,
      you might set the following parameters :

        htscanner.default_docroot = /home
        htscanner.force_default_docroot = 1

        and place a .htaccess inside /home/ that cannot be modified/deleted (and even not be read) by the user.
    EOS
  end
end
