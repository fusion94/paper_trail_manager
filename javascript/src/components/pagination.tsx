import React from "react"

export const Pagination: React.FC<{
  page: number
  hasNext: boolean
  onPageChange: (n: number) => void
}> = ({page, hasNext, onPageChange}) => {
  const goTo = (newPage: number) => {
    if (newPage > 0 && (newPage < page || hasNext)) onPageChange(newPage)
  }

  return (
    <nav className="d-flex justify-content-center my-2">
      <button
        className="btn btn-sm btn-outline-dark"
        disabled={page <= 1}
        onClick={() => goTo(page - 1)}
      >
        « Back
      </button>
      {page > 1 && (
        <button className="btn btn-sm btn-outline-dark" onClick={() => goTo(1)}>
          1
        </button>
      )}
      {page > 2 && <span> … </span>}
      {page > 3 && (
        <button
          className="btn btn-sm btn-outline-dark"
          onClick={() => goTo(page - 1)}
        >
          {page - 1}
        </button>
      )}
      <em className="mx-1">{page}</em>
      {hasNext && (
        <button
          className="btn btn-sm btn-outline-dark"
          onClick={() => goTo(page + 1)}
        >
          {page + 1}
        </button>
      )}
      <button
        className="btn btn-sm btn-outline-dark"
        disabled={!hasNext}
        onClick={() => goTo(page + 1)}
      >
        Next »
      </button>
    </nav>
  )
}
