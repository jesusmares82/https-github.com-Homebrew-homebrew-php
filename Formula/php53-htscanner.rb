require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Htscanner < AbstractPhp53Extension
  init
  homepage 'https://github.com/piannelli/htscanner-enhanced'
  url 'https://github.com/piannelli/htscanner-enhanced/archive/b62ad43105758fe9f513a0730c3bbef0dfd2ee37.tar.gz'
  sha256 'b014dafb36313c67f88b961799b9841e816de1fd3dc66bbf2ce5964c40f4e221'
  version 'b62ad431'
  head 'https://github.com/piannelli/htscanner-enhanced.git'

  bottle do
    cellar :any_skip_relocation
    sha256 "708dff46c007370dd910d77333bcfb50daf5f649537431536c7cd0b3938b2d6a" => :el_capitan
    sha256 "9b525a83086b8acb38d1126ea7aa8e2de2a725d579bd8f46d477c113a75f0c1c" => :yosemite
    sha256 "4ea3008376779fb5e84b0c2c4341e5242b9654883d667f5959053b3345de7b9c" => :mavericks
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
