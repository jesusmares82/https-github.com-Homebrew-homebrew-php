require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yaml < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/yaml"
  desc "YAML-1.1 parser and emitter"
  url "https://pecl.php.net/get/yaml-1.2.0.tgz"
  sha256 "fdf0eec6bf16b0c45e58076a2048f96140a778463724fb82ab49ab5fb4c7e19a"
  head "https://github.com/php/pecl-file_formats-yaml.git"

  bottle do
    sha256 "70fde3c416ca8b5b58e54dfdf2fde09751190c93b1e6345049b54e51414c7895" => :yosemite
    sha256 "ca14c18f6c3a83108d44e483dd51af1e6b933e25cf2bc10844747db96fc3704c" => :mavericks
    sha256 "4711ab1367c883a4e5975db28a92549ecc6b0c88f81d26e3f44c7fc9e143f838" => :mountain_lion
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
