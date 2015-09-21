require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Htscanner < AbstractPhp55Extension
  init
  homepage "https://github.com/piannelli/htscanner-enhanced"
  url "https://github.com/piannelli/htscanner-enhanced/archive/b62ad43105758fe9f513a0730c3bbef0dfd2ee37.tar.gz"
  sha256 "b014dafb36313c67f88b961799b9841e816de1fd3dc66bbf2ce5964c40f4e221"
  version "b62ad431"
  head "https://github.com/piannelli/htscanner-enhanced.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "fc0b40e48565df94321b7f08d9456450a45850265551dc58404a8e70075de3ef" => :el_capitan
    sha256 "998d4a6c4b1201661ec629e64cf7beaf81e480e2432d120132ddb782e5129db6" => :yosemite
    sha256 "3fe391e4a47107ac4eab19d06688eba6f30e189e922237c8a894256888584002" => :mavericks
  end

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
