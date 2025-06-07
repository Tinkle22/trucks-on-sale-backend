const db = require('../config/db');

class InquiryReply {
  static async findByInquiryId(inquiryId) {
    try {
      const [rows] = await db.query(
        `SELECT r.*, u.username, u.user_type 
         FROM inquiry_replies r 
         JOIN users u ON r.user_id = u.user_id 
         WHERE r.inquiry_id = ? 
         ORDER BY r.created_at ASC`,
        [inquiryId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async create(replyData) {
    try {
      const { inquiry_id, user_id, message } = replyData;
      
      const [result] = await db.query(
        'INSERT INTO inquiry_replies (inquiry_id, user_id, message) VALUES (?, ?, ?)',
        [inquiry_id, user_id, message]
      );
      
      return { reply_id: result.insertId, ...replyData, created_at: new Date() };
    } catch (error) {
      throw error;
    }
  }

  static async delete(replyId) {
    try {
      const [result] = await db.query('DELETE FROM inquiry_replies WHERE reply_id = ?', [replyId]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = InquiryReply;