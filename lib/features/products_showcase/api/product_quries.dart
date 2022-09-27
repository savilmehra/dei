String searchQuery(String search,int pasgeSize) {
  return '''
{
	products(
	filter:{}
	search:"$search"
		pageSize: $pasgeSize
		currentPage: 1
		sort: { relevance:DESC }
	) {
		items {
			id
			sku
			name
			url_key
			stock_status
			__typename
			image {
				url
				label
				position
			}
			small_image {
				url
				label
				position
			}
			thumbnail {
				url
				label
				position
			}
			... on BundleProduct {
				items {
	option_id
	uid
	title
	sku
	type
	required
	position
	options {
		id
		uid
		label
		quantity
		can_change_quantity
		is_default
		position
		price
		price_type
		product {
			uid
			id
			name
			sku
			stock_status
			price_range {
				minimum_price {
					final_price {
						value
						currency
					}
					discount {
						amount_off
						percent_off
					}
					regular_price {
						value
						currency
					}
				}
				maximum_price {
					final_price {
						value
						currency
					}
					discount {
						amount_off
						percent_off
					}
					regular_price {
						value
						currency
					}
				}
			}
		}
	}
}

			}
			price_range {
				minimum_price {
					regular_price {
						value
						currency
					}
					final_price {
						value
						currency
					}
					discount{
						amount_off
						percent_off
					}
				}
				maximum_price {
					regular_price {
						value
						currency
					}
					final_price {
						value
						currency
					}
					discount{
						amount_off
						percent_off
					}
				}
			}
			special_price
			special_to_date
			special_from_date
			price_tiers {
				quantity
				final_price {
					value
					currency
				}
				discount {
					amount_off
					percent_off
				}
			}
		}
		total_count
		aggregations {
			attribute_code
			label
			count
			options {
				count
				label
				value
			}
		}

		page_info {
			page_size
		}
	}
}
''';
}
String products(
  ) {
  return '''
  { products( filter: { category_id: { eq: "9466" }} pageSize: 5 currentPage: 1 sort: { position: null  } ) { items { id sku name url_key stock_status __typename image { url label position } price_range { minimum_price { final_price { value currency } } maximum_price { discount { amount_off percent_off } } } } total_count page_info { page_size } } }
''';
}


String loginToken(
    ) {
  return '''
{
token ("username":"roni_cost@example.com","password":"roni_cost3@example.com")
{
token}

}
''';
}

String addItem()
{
return
 ''' mutation {
    addSimpleProductsToCart(
        input: {
          cart_id: "7hdnYowNelFXS0M8LTqegy0863PzQ12u"
          cart_items: [
            {
              data: {
                quantity: 1
                sku: "TE0175809"
              }
            }
          ]
        }
    ) {
      cart {
        total_quantity
      }
    }
  }''';
}