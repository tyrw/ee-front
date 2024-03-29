'use strict'

angular.module('builder.example').controller 'exampleCtrl', (categories) ->

  storefront = this

  storefront.ee = {}

  storefront.categories = categories

  storefront.ee.User =
    user:
      logo: 'https://res.cloudinary.com/eeosk/image/upload/v1458840854/logo_300x80/fbazyy8uoxwioecljhdl.jpg'
      storefront_meta:
        name: 'Home Accents'
        brand:
          color:
            primary: '#066A68'
            secondary: '#099895'
            secondaryAccent: '#077977'
            tertiary: '#FFFFFF'
            tertiaryAccent: '#C8C8C8'
        blog: { url: 'http://eeosk.com' }
        about: { headline: 'foobar' }
        audience:
          social:
            facebook:   'facebook'
            twitter:    'twitter'
            pinterest:  'pinterest'
            instagram:  'instagram'
      categorization_ids: [1,2,3,4,5,6]
      home_carousel: [
        {
          id: 1,
          banner: 'https://res.cloudinary.com/eeosk/image/upload/v1440603589/banner/lowoyisi8p6edgktgawy.jpg'
        },
        {
          id: 2,
          banner: 'https://res.cloudinary.com/eeosk/image/upload/v1456720504/width_800/h846tqd1l2fvdppv63kc.jpg'
        },
        {
          id: 3,
          banner: 'https://res.cloudinary.com/eeosk/image/upload/v1456539390/width_800/h4o0hrit8buibyfhpgak.jpg'
        }
      ]
      home_arranged: [
        {
          id: 11,
          show_banner: false,
          products: [
            {
              id: 3
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115333/hijrsxnoedec3uraxc51.jpg'
              title: 'Classy Ceramic Garden Stool Open- Work Green'
              prices: [17099]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115296/uwrh6viymxdsbzvownny.jpg'
              title: 'Mesmerizing Styled Glass Candle Holder'
              prices: [4099]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115310/liw9altlnsjdgi9iceyi.jpg'
              title: 'Leather Mirror with Leather Finish and Brass Metallic Rivets'
              prices: [15099]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115317/td2znaggsqygklxzl9lx.jpg'
              title: 'The Beautiful Wood Real Leather Magazine Holder'
              prices: [9099]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115300/sfo5fpintcaaivn4qep7.jpg'
              title: 'Metal Wall Clock (24" Diameter)'
              prices: [5499]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115315/qxacopwjbkfg212wyzcy.jpg'
              title: 'Global worldly wood metal wall panel'
              prices: [13599]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115173/l60quadwge0cvcir7rft.jpg'
              title: 'Manhattans Coppice Exclusive Basket Dresser'
              prices: [22599]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115173/vndcqkccfxy46tlaiqmh.jpg'
              title: 'Console with Additional Storage Capability and Brass Handles'
              prices: [18099]
            }
          ]
        },
        {
          id: 12
          banner: 'https://res.cloudinary.com/eeosk/image/upload/v1456720889/width_800/zxdiiu4cwacba59vr3xs.jpg'
          show_banner: true
        },
        {
          id: 13
          show_banner: false
          products:[
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115301/jhhn5wbenblqts2752ry.jpg'
              title: 'Artistic Stars Decorative Wall Art Furnishings'
              prices: [3099]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115302/oh9cgsiuotyo4gorqvrs.jpg'
              title: 'Wall Accent Mirrors- Metal Mirror 35"W, 34"H'
              prices: [10999]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115300/u1d5tqq0jlpbhrqz0kba.jpg'
              title: 'A Pair of Poly Stone Sitting Labrador with Wooden Bookend'
              prices: [29099]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115332/b7kujwg6dqdnsosgx4yb.jpg'
              title: 'Bulldog with Bow Tie in Resin'
              prices: [3899]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115296/bdes8xdnz2em7dy1dtxk.jpg'
              title: 'Ceramic 16" Rooster in White Shade'
              prices: [4899]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115158/xgnhj4tes7m6shl3iqgb.jpg'
              title: 'Adjustable Logan Metal Stool with Wood Seat'
              prices: [8999]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429115614/ilkahrcliyf6tgja4hqr.jpg'
              title: 'Maxam® Chrome Heavy-Duty Professional Juicer'
              prices: [6499]
            },
            {
              image: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_150,h_150/v1429114984/bcffxksjshooyqino7ys.jpg'
              title: 'Dorado: Aristide Bruant dans son Cabaret (20 x 30 Framed Poster)'
              prices: [6999]
            }
          ]
        },
      ]

  ## For ngInclude partials
  # storefront.ee.Collections =
  #   nav:
  #     alphabetical: [
  #       { id: 2, title: 'Apartment Living' }
  #       { id: 3, title: 'French Inspired Design' }
  #       { id: 4, title: 'Farmhouse Favorites' }
  #       { id: 5, title: 'Gardening' }
  #       { id: 6, title: 'Kitchen Furniture' }
  #       { id: 7, title: 'Wood Grains' }
  #       { id: 8, title: 'Outdoor Fun' }
  #       { id: 9, title: 'Cooking Tools' }
  #       { id: 10, title: 'Gifts' }
  #       { id: 11, title: 'Patio Furniture' }
  #       { id: 12, title: 'Mirrors' }
  #     ]
  #     carousel: [
  #       { id: 2, title: 'Southern charm: style for your home', banner: 'https://res.cloudinary.com/eeosk/image/upload/v1440603589/banner/lowoyisi8p6edgktgawy.jpg', in_carousel: true }
  #     ]
  #
  # storefront.ee.Products =
    # products: []

  return
