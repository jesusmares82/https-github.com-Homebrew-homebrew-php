require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yaml < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/yaml"
  desc "YAML-1.1 parser and emitter"
  url "https://pecl.php.net/get/yaml-1.2.0.tgz"
  sha256 "fdf0eec6bf16b0c45e58076a2048f96140a778463724fb82ab49ab5fb4c7e19a"
  head "https://github.com/php/pecl-file_formats-yaml.git"

  bottle do
    sha256 "e00cdf29cc69b54d9b32feaf0e67c974198b04294aedd959f9cb10d80047631b" => :yosemite
    sha256 "00a0fc7a12311c3716e936547b45b62fb174f8d2815b97de4bdb72336e2257c8" => :mavericks
    sha256 "227db2c8bc9a57324558132a3696af6115dd2a5c49b4a96495e46931f8c2619c" => :mountain_lion
  end

  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
