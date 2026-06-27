# Data Analysis for a Real Estate Agency

## Overview

This project analyzes the real estate market of Saint Petersburg (SPB) and the towns of the Leningrad Region (LO). The goal is to identify the most attractive property segments to work with — based on how long listings stay active — and to uncover seasonal trends that can inform marketing campaigns and market-entry timing.

---

## Solving Ad Hoc Tasks

### Task 1. Listing Activity Time

To plan an effective business strategy in the real estate market, the client needs to determine — based on listing activity time — the most attractive property segments to work with in Saint Petersburg and the towns of the Leningrad Region.

#### 1. Which listing categories are the most common in Saint Petersburg and the towns of the Leningrad Region?

In both locations — Saint Petersburg (SPB) and the Leningrad Region (LO) — the most common category is listings with a long exposure period (181+ days):

- **Saint Petersburg:** 181+ days — 3,506 listings (the largest category)
- **Leningrad Region:** 181+ days — 873 listings (the leading category)

Consequently, a significant share of listings "stalls" on the market for more than six months. This may indicate inflated seller expectations, low demand for certain segments, or a mismatch between apartment characteristics and buyer expectations.

#### 2. Which property characteristics — including area, average price per square meter, number of rooms and balconies, and other parameters — affect listing activity time? How do these relationships vary between regions?

**Price per m²**

In Saint Petersburg, the price per m² rises as the exposure period increases:

- 1–30 days — ~108,920 ₽
- 181+ days — ~114,981 ₽

In the Leningrad Region, the price per m² changes only slightly, but the longest sales are also typical of apartments with a relatively high price.

Conclusion: the higher the price per square meter, the longer the apartment takes to sell — this is especially pronounced in Saint Petersburg.

**Apartment area**

In both regions, smaller apartments sell faster:

| Region | 1–30 days | 181+ days |
| ------ | --------- | --------- |
| SPB    | ~54.7 m²  | ~65.8 m²  |
| LO     | ~48.8 m²  | ~55.0 m²  |

**Number of rooms**

1–2-room apartments sell the fastest (median — 2 rooms in nearly all categories). In Saint Petersburg, 3-room apartments more frequently fall into the long-sale category.

**Balconies and floor**

The median is 1 balcony across all categories, meaning the number of balconies has almost no effect on the time to sale. Floor level is also stable, but in Saint Petersburg apartments on higher floors are more often in long exposure.

Conclusion: balconies and floor are not key factors in sale speed compared to price and area.

#### 3. Are there differences between the real estate of Saint Petersburg and the Leningrad Region based on the results obtained?

**Price**

Saint Petersburg is significantly more expensive than the Leningrad Region:

- SPB: 108–115 thousand ₽/m²
- LO: 67–73 thousand ₽/m²

**Area**

In SPB, larger apartments are sold, especially in long sales. In the Leningrad Region, more compact properties prevail.

**Demand structure**

In Saint Petersburg, the market is more segmented — the relationship between price, area, and time to sale is more pronounced. In the Leningrad Region, the market is more homogeneous, and changes in characteristics are less sharp.

---

### Task 2. Seasonality of Listings

The client wants to understand seasonal trends in the real estate market of Saint Petersburg and the Leningrad Region — that is, for the entire region — in order to identify periods of heightened activity among sellers and buyers. This will help plan marketing campaigns and choose the right timing for entering the market.

#### 1. In which months is the activity of publishing property-sale listings the highest? And in which months for removing them? This shows the dynamics of buyer activity.

The highest activity in publishing property-sale listings is observed in autumn — November (peak), October, and September. For removal: October, November, and September.

#### 2. Do the periods of active listing publication coincide with the periods of increased property sales (by listing-removal month)?

Yes.

#### 3. How do seasonal fluctuations affect the average price per square meter and the average apartment area? What can be said about the dependence of these parameters on the month?

The price per square meter depends on the month and shows a clearly pronounced seasonal rise toward the end of summer / beginning of autumn, and a decline in the spring period.

The average area depends only weakly on the month. Seasonal fluctuations exist, but they are insignificant compared to price. Therefore, the price increase in August–September **is not related to an increase in area**, but is driven by other factors, such as demand.

---

## General Conclusions and Recommendations

The most common listing category is apartments with an exposure of 181+ days in both regions. Sale speed is most strongly influenced by: price per square meter, total apartment area, and number of rooms. Saint Petersburg is characterized by higher prices, larger areas, and longer sale times. The Leningrad Region is a more affordable market with smaller apartments and less pronounced differences between categories.

Seasonality has a noticeable effect on the average price per square meter: the minimum values are observed in spring, and the maximum in August–September. At the same time, the average apartment area remains relatively stable throughout the year and shows only minor fluctuations. This indicates that the price growth in late summer and early autumn is primarily related to rising demand rather than to changes in the structure of the properties being sold.

### Recommendations

- Focus on mid-sized properties as the most liquid, and keep in mind that large apartments require a longer sale period.
- Do not rely on secondary parameters such as the presence of balconies; instead, emphasize area, price, and number of rooms.
- In the Leningrad Region, prices should be reviewed after 60–90 days without a deal, using the average price of comparable properties as a reference. For Saint Petersburg, a higher starting price is acceptable, but if a listing is delayed beyond 180 days, a price adjustment is also required.
- The Saint Petersburg market is less price-sensitive than the regional market. Therefore, a more flexible pricing strategy is acceptable in SPB, whereas in LO the key factors are price and area, and an inflated price significantly slows down the sale.
