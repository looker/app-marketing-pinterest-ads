explore: pinterest_ads_ad_impressions {
  persist_with: pinterest_ads_etl_datagroup
  hidden: yes
  from: pinterest_ads_ad_impressions
  view_name: fact
}

view: pinterest_ads_ad_impressions {
  extends: [ad_metrics_base, date_base, period_base, date_primary_key_base]

  derived_table: {
    datagroup_trigger: pinterest_ads_etl_datagroup
    explore_source: pinterest_ad_impressions_ad_group {
      column: _date { field: fact.date_date }
      column: channel { field: fact.network }
      column: account_id { field: fact.account_id_string }
      column: account_name { field: account.account_name }
      column: ad_group_id { field: fact.ad_group_id_string }
      column: ad_group_name { field: ad_group.ad_group_name }
      column: cost { field: fact.total_cost }
      column: impressions { field: fact.total_impressions }
      column: clicks { field: fact.total_clicks }
      column: conversions { field: fact.total_conversions }
      column: conversionvalue { field: fact.total_conversionvalue }
    }
  }

  dimension: _date {
    hidden: yes
    type: date_raw
  }
  dimension: channel {}
  dimension: account_id {
    hidden: yes
  }
  dimension: ad_group_id {
    hidden: yes
  }
  dimension: account_name {}
  dimension: ad_group_name {}
  dimension: cross_channel_ad_group_key_base {
    hidden: yes
    sql:
        concat(${channel}, ${account_id}, ${ad_group_id});;
  }
  dimension: key_base {
    hidden: yes
    sql: ${cross_channel_ad_group_key_base} ;;
  }
}
