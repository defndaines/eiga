defmodule IMDbDataWeb.ReviewControllerTest do
  use IMDbDataWeb.ConnCase

  import IMDbData.MoviesFixtures

  @create_attrs %{rating: 2.5, tconst: "some tconst", votes: 42}
  @update_attrs %{rating: 6.7, tconst: "some updated tconst", votes: 43}
  @invalid_attrs %{rating: nil, tconst: nil, votes: nil}

  describe "index" do
    test "lists all reviews", %{conn: conn} do
      conn = get(conn, Routes.review_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Reviews"
    end
  end

  describe "new review" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.review_path(conn, :new))
      assert html_response(conn, 200) =~ "New Review"
    end
  end

  describe "create review" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.review_path(conn, :create), review: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.review_path(conn, :show, id)

      conn = get(conn, Routes.review_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Review"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.review_path(conn, :create), review: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Review"
    end
  end

  describe "edit review" do
    setup [:create_review]

    test "renders form for editing chosen review", %{conn: conn, review: review} do
      conn = get(conn, Routes.review_path(conn, :edit, review))
      assert html_response(conn, 200) =~ "Edit Review"
    end
  end

  describe "update review" do
    setup [:create_review]

    test "redirects when data is valid", %{conn: conn, review: review} do
      conn = put(conn, Routes.review_path(conn, :update, review), review: @update_attrs)
      assert redirected_to(conn) == Routes.review_path(conn, :show, review)

      conn = get(conn, Routes.review_path(conn, :show, review))
      assert html_response(conn, 200) =~ "some updated tconst"
    end

    test "renders errors when data is invalid", %{conn: conn, review: review} do
      conn = put(conn, Routes.review_path(conn, :update, review), review: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Review"
    end
  end

  describe "delete review" do
    setup [:create_review]

    test "deletes chosen review", %{conn: conn, review: review} do
      conn = delete(conn, Routes.review_path(conn, :delete, review))
      assert redirected_to(conn) == Routes.review_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.review_path(conn, :show, review))
      end
    end
  end

  defp create_review(_) do
    review = review_fixture()
    %{review: review}
  end
end
