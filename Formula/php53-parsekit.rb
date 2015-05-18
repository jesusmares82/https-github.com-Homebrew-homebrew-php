require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Parsekit < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/parsekit"
  desc "PHP Opcode Analyser"
  url "https://pecl.php.net/get/parsekit-1.3.0.tgz"
  sha256 "447d5ec6412d6c8c6489b03e7333d3872944444610b74eafd608eddcb3bbaf08"
  head "https://github.com/php/pecl-php-parsekit.git"

  def install
    Dir.chdir "parsekit-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/parsekit.so"
    prefix.install "examples"
    write_config_file if build.with? "config-file"
  end

  test do
    Dir.chdir prefix
    shell_output("php -m").include?("parsekit")\
      && shell_output("php examples/compile_file.php")\
      && shell_output("php examples/compile_string.php")
  end
end
