require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xhprof < AbstractPhp56Extension
  init
  homepage 'https://github.com/facebook/xhprof'
  url 'https://github.com/facebook/xhprof/archive/254eb24dcfa763c76c57b472093ebc4b81af2b7d.tar.gz'
  sha1 'bab248d9a44a99515f96eb086bfa9d8932874451'
  head 'https://github.com/facebook/xhprof.git'
  version '254eb24'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "c480499dd18cf90a7a7202ec3f9039b6b0cf88d8" => :yosemite
    sha1 "73abb71178efc8a9489ccd97628e34142bf882c9" => :mavericks
    sha1 "451676821cd45ddeaa92fd5dba3da178dd69bdfe" => :mountain_lion
  end

  depends_on 'pcre'

  def install
    Dir.chdir "extension" do
      ENV.universal_binary if build.universal?

      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install "modules/xhprof.so"
    end

    prefix.install %w(xhprof_html xhprof_lib)
    write_config_file if build.with? "config-file"
  end
end
