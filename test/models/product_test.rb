require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "My book title", description: "yyy")
    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")
    product.price = BigDecimal(-1)
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]

    product.price = BigDecimal(0)
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]

    product.price = BigDecimal(1)
    assert product.valid?
  end

  test "image url" do
    product = Product.new(title: "My book title", description: "yyy", price: BigDecimal(1))
    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")
    assert product.valid?, "image/jpeg must be valid"

    product = Product.new(title: "My book title", description: "yyy", price: BigDecimal(1))
    product.image.attach(io: File.open("test/fixtures/files/logo.svg"), filename: "lorem.jpg", content_type: "image/svg+xml")
    assert_not product.valid?, "image/svg+xml must be invalid"
  end

  test "Product is not valid without a unique title" do
    product = Product.new(title: products(:pragprog).title, description: "yyy", price: BigDecimal(1))
    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")

    assert product.invalid?
    assert_equal [ "has already been taken" ], product.errors[:title]
    # assert_equal [I18n.translate("errors.messages.taken")], product.errors[:title]
  end
end

def new_product(image_url)
  Product.new(title: "My book title", description: "yyy", price: BigDecimal(1))
  product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")
end
