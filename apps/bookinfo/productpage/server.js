const express = require("express");
const axios = require("axios");
const app = express();
const path = require("path");

const port = 9080;

var AWSXRay = require("aws-xray-sdk");
app.use(AWSXRay.express.openSegment("productpage"));

var detailsHostname = process.env.DETAILS_HOSTNAME;
var detailsUrl = detailsHostname
  ? "http://" + detailsHostname + ":9080/details"
  : "http://localhost:8001/details";

var reviewsHostname = process.env.REVIEWS_HOSTNAME;
var reviewsUrl = reviewsHostname
  ? "http://" + reviewsHostname + ":9080/reviews"
  : "http://localhost:8002/reviews";

console.log("detailsUrl -> ", detailsUrl);
console.log("reviewsUrl -> ", reviewsUrl);

// ========================
// Middlewares
// ========================
app.set("view engine", "ejs");
app.use(express.static(path.join(__dirname, "public")));

app.use(express.urlencoded({ extended: true }));

async function getDetails(url) {
  try {
    const detailsResponse = await axios.get(url);
    return { status: detailsResponse.status, data: detailsResponse.data };
  } catch (error) {
    console.log("getDetails error ", error);
    return {
      status: 500,
      error: "Sorry, product details are currently unavailable for this book.",
    };
  }
}

async function getReviews(url) {
  try {
    const reviewsResponse = await axios.get(url);
    return { status: reviewsResponse.status, data: reviewsResponse.data };
  } catch (error) {
    console.log("getReviews error ", error);
    return {
      status: 500,
      error: "Sorry, product reviews are currently unavailable for this book.",
    };
  }
}

app.get("/", async (req, res) => {
  const product = await getProduct();
  const details = await getDetails(detailsUrl + "/0");
  console.log("details -> ", details);
  const reviews = await getReviews(reviewsUrl + "/0");
  console.log("reviews -> ", JSON.stringify(reviews));

  res.render("productpage.ejs", {
    product,
    details,
    reviews,
  });
});

const getProduct = async () => {
  return {
    id: 0,
    title: "The Comedy of Errors",
    descriptionHtml:
      '<a href="https://en.wikipedia.org/wiki/The_Comedy_of_Errors">Wikipedia Summary</a>: The Comedy of Errors is one of <b>William Shakespeare\'s</b> early plays. It is his shortest and one of his most farcical comedies, with a major part of the humour coming from slapstick and mistaken identity, in addition to puns and word play.',
  };
};

app.get("/health", (req, res, next) => {
  res.json("Healthy");
});

app.use(AWSXRay.express.closeSegment());

app.listen(port, function () {
  console.log("productpage listening on " + port);
});
