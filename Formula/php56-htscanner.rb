require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Htscanner < AbstractPhp56Extension
  init
  homepage 'https://github.com/piannelli/htscanner-enhanced'
  url 'https://github.com/piannelli/htscanner-enhanced/archive/b62ad43105758fe9f513a0730c3bbef0dfd2ee37.tar.gz'
  sha256 'b014dafb36313c67f88b961799b9841e816de1fd3dc66bbf2ce5964c40f4e221'
  version 'b62ad431'
  head 'https://github.com/piannelli/htscanner-enhanced.git'

  bottle do
    cellar :any_skip_relocation
    sha256 "cbb74ed0a78bb4758a0628f7ed6ed952efcd1fc94903835373a95ea1849dcdae" => :el_capitan
    sha256 "556a1ae7482b095727142c6eccaef64f5ff1ebc49ab118a235518859d0c1d24a" => :yosemite
    sha256 "0572531f20a9a80fc542778c9559da54d9ccebeeb90c78cdf924ec0f45c276ee" => :mavericks
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
