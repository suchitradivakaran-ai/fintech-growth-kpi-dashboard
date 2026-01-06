## Layer 6: Power BI Output Tables

This layer contains final, clean SQL queries designed specifically
to feed Power BI dashboards.

Outputs are flat, aggregated tables optimised for visualisation
and periodic refresh.

## Final Power BI Output Queries

This folder documents the final SQL queries whose outputs were exported as CSV
and used directly in Power BI dashboards.

These queries represent the final, consumption-ready datasets and separate
analytical logic from visualisation layers.

### Power BI Page Mapping

- Growth Overview → Layer 2 growth queries
- Engagement Overview → Layer 3 engagement queries
- Funnel Overview → Layer 4 funnel conversion query
- Transaction Overview → Layer 5 transaction summary & value proxy queries

In a production environment, these queries would be materialised as views
to support automated dashboard refreshes.
